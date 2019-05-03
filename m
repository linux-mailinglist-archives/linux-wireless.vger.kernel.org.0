Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D2B12C60
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfECL2V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:28:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfECL2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:28:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B04E611C3; Fri,  3 May 2019 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556882900;
        bh=nikhLOcwOCi/ylPbM7C79U06YK8dSN1QSC8O4xMcJg0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jOhrxEhjDKVcknu7tGCljxId1T3zfjG3uUsfU/shPpj/ufGCtrfvGH/Yh/ZDhG4Tp
         GyHZBbEUbsfNgoHScdkEWH8MY75OEa8bJEch7nzbA+30aJmhJcsCziIhaTegYsQyN4
         qXNb+OIiTNNvKdgzCtFCK7Mz9gnxBHw01l0RIf5g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F6F460E41;
        Fri,  3 May 2019 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556882899;
        bh=nikhLOcwOCi/ylPbM7C79U06YK8dSN1QSC8O4xMcJg0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iQTZsJtnM9UR01LleeSqDUrLPWAZUXIXMTRJbRcfQjyubEWp7mNfh4aEx5l4ntNoz
         KwCPP91QBgH1i2sTEpFW7Zb7/4WlNaFjHOKBqItFAuNNSlMFufkpaXO6sem80KaOAG
         rTXBcKoBXKNKTy8KtsLNlRlHz5fWsrx+BS7p645k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F6F460E41
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Manikanta Pubbisetty <mpubbise@codeaurora.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] {nl,mac}80211: allow 4addr AP operation on crypto controlled devices
References: <1556881402-28078-1-git-send-email-mpubbise@codeaurora.org>
Date:   Fri, 03 May 2019 14:28:15 +0300
In-Reply-To: <1556881402-28078-1-git-send-email-mpubbise@codeaurora.org>
        (Manikanta Pubbisetty's message of "Fri, 3 May 2019 16:33:22 +0530")
Message-ID: <87bm0jwze8.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <mpubbise@codeaurora.org> writes:

> As per the current design, in the case of sw crypto controlled devices,
> it is the device which advertises the support for AP/VLAN iftype based
> on it's ability to tranmsit packets encrypted in software
> (In VLAN functionality, group traffic generated for a specific
> VLAN group is always encrypted in software). Commit db3bdcb9c3ff
> ("mac80211: allow AP_VLAN operation on crypto controlled devices")
> has introduced this change.
>
> Since 4addr AP operation also uses AP/VLAN iftype, this conditional
> way of advertising AP/VLAN support has broken 4addr AP mode operation on
> crypto controlled devices which do not support VLAN functionality.
>
> In the case of ath10k driver, not all firmwares have support for VLAN
> functionality but all can support 4addr AP operation. Because AP/VLAN
> support is not advertised for these devices, 4addr AP operations are
> also blocked.
>
> Fix this by allowing 4addr operation on devices which do not support
> AP/VLAN iftype but can support 4addr AP operation (decision is based on
> the wiphy flag WIPHY_FLAG_4ADDR_AP).
>
> Fixes: Commit db3bdcb9c3ff ("mac80211: allow AP_VLAN operation on crypto controlled devices")

The correct format for the Fixes line is:

Fixes: db3bdcb9c3ff ("mac80211: allow AP_VLAN operation on crypto controlled devices")

-- 
Kalle Valo
