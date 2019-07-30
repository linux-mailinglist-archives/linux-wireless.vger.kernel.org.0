Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A227A340
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 10:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfG3ImT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 04:42:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfG3ImS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 04:42:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D1551602BC; Tue, 30 Jul 2019 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564476137;
        bh=oxGiXkDZtta9r/yUNLTIpeOlXyBonkA7NnliY8ghQIk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LDRtInuP9pdGrcmcAoiLYD+QQYawKhgdPmoc8kOgJzWCQkkNM4LL/sHKLAel2bO9X
         r2NKYzXuDmZYZ/HPR7j/bQ5SQYVqclSVKjzZr5sWB51BZmMtDEyqZxKb4kCWYqDyzs
         bFRu0PVtjWiA9lzN0UmglspbK8KXO9FW65iC0bw8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85BA660364;
        Tue, 30 Jul 2019 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564476137;
        bh=oxGiXkDZtta9r/yUNLTIpeOlXyBonkA7NnliY8ghQIk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LDRtInuP9pdGrcmcAoiLYD+QQYawKhgdPmoc8kOgJzWCQkkNM4LL/sHKLAel2bO9X
         r2NKYzXuDmZYZ/HPR7j/bQ5SQYVqclSVKjzZr5sWB51BZmMtDEyqZxKb4kCWYqDyzs
         bFRu0PVtjWiA9lzN0UmglspbK8KXO9FW65iC0bw8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85BA660364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lukas Redlinger <lukas.redlinger@agilox.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: ath10k: Fix channel info parsing for non tlv target
References: <CAN5HydqLuX=gg-j6kn_nzTTvxgKxdYaB3ZviVH_+ZD694pHJoQ@mail.gmail.com>
Date:   Tue, 30 Jul 2019 11:42:13 +0300
In-Reply-To: <CAN5HydqLuX=gg-j6kn_nzTTvxgKxdYaB3ZviVH_+ZD694pHJoQ@mail.gmail.com>
        (Lukas Redlinger's message of "Mon, 29 Jul 2019 11:13:37 +0200")
Message-ID: <87sgqnrk0q.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lukas Redlinger <lukas.redlinger@agilox.net> writes:

> My x86_64 system with Arch Linux 5.2.2 and a Compex WLE600VX card is
> filling the log with "ath10k_pci 0000:01:00.0: failed to parse chan
> info event: -71".
>
> WiFi in general works, but wavemon is struggling as some packets seem
> to be incomplete.
> This seems to be the fix: https://patchwork.kernel.org/patch/10844513/
>
> How/when will i get mainline? Can I speed up the process somehow?

Do to various reasons ath10k patches have been queuing up quite a lot,
that's why the delay. I'll try to push this to 5.3.

-- 
Kalle Valo
