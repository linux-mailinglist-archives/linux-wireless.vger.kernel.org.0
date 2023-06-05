Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDAF72250A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjFEL6e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjFEL6c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 07:58:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA0D131
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DtgsoVFYt/Q+J8AhlsjT89LVYTX0qwrmzXOLODF2GmA=;
        t=1685966304; x=1687175904; b=mcrDRe46J++LIvY0Vd+ZQJ0lrCY6j+4KkUZolnbfHb5Nq53
        WZvPNBhbaUThCHmMXzB9JICK60um8C6DG4lejmd4rZ9VA0kSDCdRDo90v4EvXvJKe9SUw7chqDGCY
        zfJvlnLczDPRLKDOFidMCuYNngBYrCAi6DM7Kyqg6J3EOJg6Gu2fP6pU6Sjs7oY3M274C/vh2vss6
        /dn/EmfU0c2I4vnnspxXyliSw1LzED5eDwIVm8xj0VlzKLH1mIGciDm7qFVFXbyGva9sNBdQizgS6
        wAGrOvigwH162UshQaRnYwNQ58BNdMceF61KpUaeJ7aeg2t2dGiZ9W3UXeIZF0tg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q68qr-00ERWy-2T;
        Mon, 05 Jun 2023 13:58:21 +0200
Message-ID: <9a691000231beaf82c4f83aa0ac54fde8f74b133.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211 : Add support to track mesh peer beacon miss
 event
From:   Johannes Berg <johannes@sipsolutions.net>
To:     quic_haric@quicinc.com
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 05 Jun 2023 13:58:20 +0200
In-Reply-To: <1653893292-11092-1-git-send-email-quic_haric@quicinc.com>
References: <1653893292-11092-1-git-send-email-quic_haric@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-05-30 at 12:18 +0530, quic_haric@quicinc.com wrote:
>=20
> =20
> +static ssize_t dbg_mask_read(struct file *file, char __user *user_buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct ieee80211_local *local =3D file->private_data;
> +	char buf[128];
> +	int len;
> +
> +	len =3D scnprintf(buf, sizeof(buf), "0x%x\n", local->hw.dbg_mask);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}
>=20

I'm also really not sure I want to get behind another bespoke debug
configuration system ...

johannes
