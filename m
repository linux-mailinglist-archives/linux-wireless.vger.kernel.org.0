Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C241C0532
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfI0MdK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 08:33:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfI0MdJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 08:33:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 46D7460A78; Fri, 27 Sep 2019 12:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569587588;
        bh=r8P0kTWFs5BN/PAIrml16HxhQSxByv11rct0foYZLGc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=L9qn8RT6xZ4wbcsRpV1JbAIQB2wDlooRGkDSIIb4VR6rheWVGM+nREe1BspPPqp6N
         khDGiUGDtcz8wIUVBA15X3rLyegLh2Bnb5a54/4Rtz1CBVDyPZj7xqsA5252pUdi2p
         nAnvHFbI4tJr3cN/reR2xSG21b1x977iJPDYlrhA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0D07608CC;
        Fri, 27 Sep 2019 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569587587;
        bh=r8P0kTWFs5BN/PAIrml16HxhQSxByv11rct0foYZLGc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RFv5nTSNu+dIox97OpCHi6fEdAr+gbGzLwWaHHnXoVQ/xs28RkMGs5ISu1rnK8y9L
         b9pKuKhT/KskhyetDjwc9eXAeh2m7ptyGy7+YAR+KLyo/MaTF9e5bCvyAI5aRNAP5b
         awI4cuLEn27eHIRA7rn2i/08T06DAkZDlr66SCnQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0D07608CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Norbert Preining <norbert@preining.info>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilw@linux.intel.com
Subject: Re: IWL AC 8260, kernel 5.3.*, many kernel WARNING
References: <20190927010452.b576njhcvgowasf3@burischnitzel.preining.info>
Date:   Fri, 27 Sep 2019 15:33:02 +0300
In-Reply-To: <20190927010452.b576njhcvgowasf3@burischnitzel.preining.info>
        (Norbert Preining's message of "Fri, 27 Sep 2019 10:04:52 +0900")
Message-ID: <87blv5j4w1.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Norbert Preining <norbert@preining.info> writes:

> Dear all,
>
> (please cc)
>
> linux 5.3.1
> Debian/sid
> Thinkpad X260
> iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
> iwlwifi 0000:04:00.0: loaded firmware version 36.8fd77bb3.0 op_mode iwlmvm
>
> since about 5.3.0 I get a lot of warnings in the syslog about iwlmvm.
>
> It starts with
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: Microcode SW error detected.  Restarting 0x82000000.
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: Status: 0x00000080, count: 6
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: Loaded firmware version: 36.8fd77bb3.0
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: 0x00000038 | BAD_COMMAND
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: 0x000002F0 | trm_hw_status0
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
> ....
>
> after that
> Sep 27 09:08:35 burischnitzel kernel: ieee80211 phy0: Hardware restart was requested
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: FW Error notification: seq 0x0030 service 0x00000005
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: FW Error notification: timestamp 0x000000000037F460
> Sep 27 09:08:35 burischnitzel kernel: iwlwifi 0000:04:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT

I'm guessing this should fix it:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=fddbfeece9c7882cc47754c7da460fe427e3e85b

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
