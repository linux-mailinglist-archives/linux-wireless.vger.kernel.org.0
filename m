Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31825292305
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 09:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgJSHiE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 03:38:04 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:25485 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbgJSHiE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 03:38:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603093084; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=b0KYk10QRZOTg/+KAFbaiQ/ly9C7uiQr8m4I6m3yeno=; b=CegiqDdrmuLRzEWrSylqpONh1bMcAS9Adbv46DNjNtPqN+KYzA//+TKtByzHwE2pnOsEx9l2
 CZ1haah7tgmjyMb46jcDFT7bdh7GqpXYVsMr+u77wCTHCPouTixHzrl3x87m5Vt3LBKo6831
 FI73cPuqI46NcFwfv9Lwp3VY/tM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f8d4228ef891f1ee20373be (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Oct 2020 07:37:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF7D2C43387; Mon, 19 Oct 2020 07:37:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BCA5C433F1;
        Mon, 19 Oct 2020 07:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BCA5C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     David Rubio <david.alejandro.rubio@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Andy Huang <tehuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
        <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
        <362f154dff1b4d6f88503af813eae406@realtek.com>
        <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
        <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
        <87h7qrq4p5.fsf@tynnyri.adurom.net>
        <CAO6ttSkXSt3UC5P-RDCDUhDC66MRb5UkvCcbT5POzkve9G=GyA@mail.gmail.com>
Date:   Mon, 19 Oct 2020 10:37:07 +0300
In-Reply-To: <CAO6ttSkXSt3UC5P-RDCDUhDC66MRb5UkvCcbT5POzkve9G=GyA@mail.gmail.com>
        (David Rubio's message of "Sun, 18 Oct 2020 19:51:42 -0300")
Message-ID: <87y2k2hdjw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Rubio <david.alejandro.rubio@gmail.com> writes:

> There's no possibility of including it on 5.10 changes? Seems like a
> trivial patch Or did the merge window pass already? I'm not aware of
> it by now.

wireless-drivers-next goes via net-next and the deadline for net-next is
before the merge window opens, so it's too late for v5.10.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
