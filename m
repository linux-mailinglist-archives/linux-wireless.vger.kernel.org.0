Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A460C7E5D6B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 19:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjKHSnU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 13:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSnT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 13:43:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E4210A
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 10:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=InEJJdRO8+GTrLbB/VfoXbwxZLOImMezoUQnYMyoVzQ=;
        t=1699468997; x=1700678597; b=jTaznapG6OimEoH4GlHdgkPdVGLkYpKhNxIPAmpPu0vBIOC
        QOmtICI/WIim/RgW3/UjPA03kU4gHsgOzQtWa0UVzROpZjItLiMwVJq6nj3vMl8NrzFASL/7jC19J
        cty88PZAASIq63Le9+K+6Es0ARp4C1HpeCHTkEcxtp8aXEya8q/v3OYUurQXhfHoTExdwq3TUXB67
        JOXzfexs9g6icrkwKY57UaZIld3TjcQr7Es9dSRuhlXSrNDjcJDjcqGOKrG+JfMUowyW7Fmx/+tIV
        09Elc1Uy9LtRUlZ1r97Oow9LRuM5NnQFQF75TXzrEbZhTqvVoOiJXPywyUmIX2Hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0nWE-00000000haW-3So8;
        Wed, 08 Nov 2023 19:43:15 +0100
Message-ID: <6abad7701a110116a49e54f908a9ab9422a8e6ad.camel@sipsolutions.net>
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Nicolai Stange <nicstange@gmail.com>
Date:   Wed, 08 Nov 2023 19:43:13 +0100
In-Reply-To: <21a4b983-1d5c-8c76-0994-d8a43285b19d@candelatech.com>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
         <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
         <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
         <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
         <dd6c7cf2-1955-4c70-fd2f-ffe2915111f4@candelatech.com>
         <0cfd8ae0577e52fe8db41dbfb37ee5197a1857d6.camel@sipsolutions.net>
         <21a4b983-1d5c-8c76-0994-d8a43285b19d@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-11-08 at 09:44 -0800, Ben Greear wrote:
>=20
> This method appears to actually set a S_DEAD flag in the dentry,
>=20

A *dir* entry.

>  so maybe
> we just check that flag in the mutex_trylock failed to acquire path
> in the debugfs read?
>=20
> void simple_recursive_removal(struct dentry *dentry,
>                                void (*callback)(struct dentry *))
> {
> 	struct dentry *this =3D dget(dentry);
> 	while (true) {
> 		struct dentry *victim =3D NULL, *child;
> 		struct inode *inode =3D this->d_inode;
>=20
> 		inode_lock(inode);
> 		if (d_is_dir(this))
> 			inode->i_flags |=3D S_DEAD;
>=20

But even if you did that, I'm not sure what you'd do? trylock and sleep,
and abort if you find it's being removed? That all sounds super awkward.

johannes
