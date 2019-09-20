Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3F1B8B8C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395036AbfITHcJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 03:32:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390886AbfITHcJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 03:32:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8376611FA; Fri, 20 Sep 2019 07:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568964727;
        bh=zNsWy2u6n6HzmF1aqQcu7lzBtU18yJm2gBRMbb1Db9E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W+xCXZAGvE5fE9l0+L9rt+wyIVSFaGrmLrn7EgltTOctt1jRVgddry3WFqzzu9VRl
         6cv7MKCnG8ApWKz6zcVbODHXHQFW/do36XToerR8Ae41/wmX3/4wMyuzpYxSXQ/2ny
         T2Ixwrujq6vbjBBc7Qi6DD+9qVJr6XNUhZ0cMWUw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 997556076C;
        Fri, 20 Sep 2019 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568964726;
        bh=zNsWy2u6n6HzmF1aqQcu7lzBtU18yJm2gBRMbb1Db9E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UJYct5meuokyAsXba9WDwOZ2WpIHtsb6Zbrd9R29+UTOAWeOjdRPEQ5fV6j/iuIks
         Ecn6TmQosT4EKpdatlbhZTcqEd/UPp4ny2Z9kujjUvnLzPwuq5TfzY11ltROwcP/HF
         e50xGulSZiZiMlonZ/4LepXAtOve8Ag3nLNKWBRo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 997556076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@qti.qualcomm.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Subject: Re: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
References: <1534402113-14337-1-git-send-email-wgong@codeaurora.org>
        <20181114225910.GA220599@google.com>
        <CA+ASDXMh7vdfkA5jtJqWEU-g-4Ta5Xvy046zujyASZcESCGhAQ@mail.gmail.com>
        <87woe5aehr.fsf@kamboji.qca.qualcomm.com>
        <40854e84bd4b4a9699b60530b1c373ad@aptaiexm02f.ap.qualcomm.com>
Date:   Fri, 20 Sep 2019 10:32:02 +0300
In-Reply-To: <40854e84bd4b4a9699b60530b1c373ad@aptaiexm02f.ap.qualcomm.com>
        (Wen Gong's message of "Fri, 20 Sep 2019 02:55:08 +0000")
Message-ID: <87pnjvctjh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@qti.qualcomm.com> writes:

>> -----Original Message-----
>> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Kalle Valo
>> Sent: Wednesday, September 18, 2019 10:03 PM
>> To: Brian Norris <briannorris@chromium.org>
>> Cc: linux-wireless <linux-wireless@vger.kernel.org>; Linux Kernel <linux-
>> kernel@vger.kernel.org>; ath10k@lists.infradead.org; Wen Gong
>> <wgong@codeaurora.org>
>> Subject: [EXT] Re: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
>> 
>> So essentially the problem is that with firmwares supporting both
>> WMI_SERVICE_NLO and WMI_SERVICE_SPOOF_MAC_SUPPORT ath10k
>> enables
>> NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR, but
>> NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR is not enabled
>> which is
>> inconsistent from user space point of view. Is my understanding correct?
>> 
>> Wen, can you enable NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR?
>> Does firmware
>> support that?
>
> Yes, I test again, it is enabled NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR now.

Sorry, I'm not quite understanding your reply.

But I mixed up the flags. I meant that can we enable
NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR in ath10k? Does the firmware
releases which have WMI_SERVICE_NLO support
NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR as well?

-- 
Kalle Valo
