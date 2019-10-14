Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF0D5E22
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfJNJGz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:06:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47470 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730432AbfJNJGz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:06:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7370060A74; Mon, 14 Oct 2019 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044014;
        bh=M7ALvQe5/pxZGs7fd05A0n6RK90esmpXEcrfHiiaBmY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gsOEDc9Al7L7gFyr30I+p9LKxtVOCQLnUWRJ/rWyeFiEGNMobRnSBtKPjT0r0pkaI
         Kwa12EGuNrGk8dDyOAfW6ycxvhKu8Zf6Nh7cdM/S0bxj7L6hez4gRSOgIQftdT5s5v
         hs/FV1ScHyhj1JlehqiJQnx5lOeuOkFk2PK6icm0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3455460A0A;
        Mon, 14 Oct 2019 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044010;
        bh=M7ALvQe5/pxZGs7fd05A0n6RK90esmpXEcrfHiiaBmY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=R+kLxDYYspMeBXt1y7A6+NxyDcppgNAeDbgHr/Vo9tMHePtXdFme8XDow6B4LUe10
         fohRZUznjx/Cd19T0gFFYgkmIuHPD0KftflXN/Ns2xiA2QUQ1CbwpwaYUX4s3tjzr/
         LNK9llILfhsqmnTcPbzLBXRP3E9RZosVu7OkMIGw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3455460A0A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kan Yan <kyan@google.com>
Cc:     johannes@sipsolutions.net, make-wifi-fast@lists.bufferbloat.net,
        toke@redhat.com, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, yiboz@codeaurora.org, nbd@nbd.name
Subject: Re: [PATCH v4 0/2] Implement Airtime-based Queue Limit (AQL)
References: <20191011022413.176208-1-kyan@google.com>
Date:   Mon, 14 Oct 2019 12:06:45 +0300
In-Reply-To: <20191011022413.176208-1-kyan@google.com> (Kan Yan's message of
        "Thu, 10 Oct 2019 19:24:11 -0700")
Message-ID: <87wod7y9ui.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> This patch series implements Airtime-based Queue Limit (AQL) in the mac80211 and Ath10k driver. It is based on an earlier version from the ChromiumOS tree[0].
>
> This version has been tested with QCA9884 platform with 4.14 kernel. Tests show AQL is able to reduce latency by an order of magnitude in a congested environment without negative impact on the throughput.
>
> [0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1703105/7
>
> Kan Yan (2):
>   mac80211: Implement Airtime-based Queue Limit (AQL)
>   ath10k: Enable Airtime-based Queue Limit (AQL)

Please always include a change log so that people know what has changed
since the previous version:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
