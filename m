Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778541241B4
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 09:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLRIae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 03:30:34 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:23700 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfLRIad (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 03:30:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576657833; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=PIDnSUBEUbgx5AopOOnFyF0n0XHTGYggYiI8NuZSaJs=; b=auuXV3gE9l9MaQhxR012I5CMmCu0zZRCwS73F/ynOejb4IrbwZRIrVxhRkdLVIif/neppzqk
 lfuU+lA6V3Fo2Gw+SlVXZyjr3uDOvMahS5gOYpTKRzyeiSdlMVKRKc8jp6FthFbktU4+74qU
 pAYMTwGd56ldgiVenQMN2ZMSMSo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df9e3a3.7f80e361bab0-smtp-out-n03;
 Wed, 18 Dec 2019 08:30:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9BDDAC447A9; Wed, 18 Dec 2019 08:30:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE561C4479D;
        Wed, 18 Dec 2019 08:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE561C4479D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com
Subject: Re: [PATCH] mt76: fix compilation warning in mt76_eeprom_override()
References: <a64aaf778d3d144a46678f2833db2ec0afa3c58a.1576521036.git.lorenzo@kernel.org>
Date:   Wed, 18 Dec 2019 10:30:21 +0200
In-Reply-To: <a64aaf778d3d144a46678f2833db2ec0afa3c58a.1576521036.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Mon, 16 Dec 2019 19:32:10 +0100")
Message-ID: <87bls63ujm.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix the following compilation warning in mt76_eeprom_override routine
> when CONFIG_OF is not set and label 'out' is not actually used
>
> drivers/net/wireless/mediatek/mt76/eeprom.c: In function =E2=80=98mt76_ee=
prom_override=E2=80=99:
> drivers/net/wireless/mediatek/mt76/eeprom.c:100:1: warning: label =E2=80=
=98out=E2=80=99 defined but not used [-Wunused-label]
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

What commit introduced this? Or is this an old issue?

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
