Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD65945B8AC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 11:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbhKXKxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 05:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbhKXKxk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 05:53:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C257C061714
        for <linux-wireless@vger.kernel.org>; Wed, 24 Nov 2021 02:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=h8DM242hIuWswmDBjRaBHEiCMyVQYWmXlNkL12GEkBE=;
        t=1637751031; x=1638960631; b=uuS3xznClwhfYFTRk/21ptRyQkxf6ZnWHZF6h6sNc54C/uO
        rDfwiunVhSG/7QVwYKi+BJzj4SqKK7C1Ker+K7OsZ8gBu1eZXHowhtXEfQio8u5/Ev4hBWjcbyUEE
        blmqiggryaOoArvdHfmh468OlN1AjvxWriTJrqdppwH4ny4ad+6JIGGgNG1Sc87Z08E6rMb4XrFSi
        giH1r8cA6MVbVi8oZVxSjHDrUMJKGQbeeclj2WYNTyZRPIRH6U7Qw+IrFXsYsAHDhBmhPRMXN0PoZ
        ajOI6P2aGD8vfD+whY/sY0dDPoQOVVLIBNb+9w3OYCgLMZRz/qkvhPuHxj977+2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mppr6-002FL9-RE;
        Wed, 24 Nov 2021 11:50:24 +0100
Message-ID: <08617202caac2c141955115cc2fdac2191c398b9.camel@sipsolutions.net>
Subject: Re: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A=5BPATCH=5D?= net: fix
 incorrect return code
From:   Johannes Berg <johannes@sipsolutions.net>
To:     =?UTF-8?Q?=E5=88=98=E5=9B=BD=E5=BC=BA?= <liuguoqiang@uniontech.com>
Cc:     davem <davem@davemloft.net>, kuba <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 24 Nov 2021 11:50:24 +0100
In-Reply-To: <tencent_32DC18DA2901E67504F97177@qq.com>
References: <20211124100151.31233-1-liuguoqiang@uniontech.com>
         <54c903dfff255cda79c9c5e7610b678710a795ab.camel@sipsolutions.net>
         <tencent_32DC18DA2901E67504F97177@qq.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-11-24 at 18:29 +0800, 刘国强 wrote:
> which return type is wrong? EOPNOTSUPP or check_sdata_in_driver 

The return *type* of drv_can_aggregate_in_amsdu() should be bool.

johannes
