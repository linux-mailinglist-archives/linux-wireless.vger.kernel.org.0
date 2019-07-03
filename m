Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9E5E30E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 13:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGCLqF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 07:46:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCLqE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 07:46:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 571F2607B9; Wed,  3 Jul 2019 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562154364;
        bh=8BEze9mtv/doYlDtCTU2I1B7HbgBS22fjIdTmYue8G8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PLWxU52xyP2Jbf1VRyAg0ZUc4o5YXuxPDMP+aIBxAIyUVrTCAyj/y3+zSBugWERCP
         hMFM6m6sLXNZyflYemzRFJeVLOLAGv/yoHdjNf7LnoQ7kYtJkW6zWW1g2ryJa+Ixdu
         ttlaDE+jShoHdxSXKg4CSAGfKP0q+RbwehcNtVR0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (176-93-70-152.bb.dnainternet.fi [176.93.70.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B1CA607DE;
        Wed,  3 Jul 2019 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562154359;
        bh=8BEze9mtv/doYlDtCTU2I1B7HbgBS22fjIdTmYue8G8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UhXprxVMNlCGPNw3SioKzH27begqlYvFalhIYgqJB4oVc5L9ddCAwYdfGxInj/p6A
         XNv575HNw+C94GClch2pf9R4ZGDy+N7u7Px/HOQScaT0nRVYX8du9nw2iho1YZ6g7X
         I/Cud5W226BP3GJ6WcCvB0jTQ4spcrslVWDWeUbg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B1CA607DE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        emmanuel.grumbach@intel.com, johannes.hirte@datenkhaos.de,
        steven@uplinklabs.net, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH for v5.2] iwlwifi: mvm: disable TX-AMSDU on older NICs
References: <20190703081049.28831-1-luca@coelho.fi>
        <1d7609a45e38725d57c2f78b5e437b83b7e49197.camel@coelho.fi>
Date:   Wed, 03 Jul 2019 14:45:54 +0300
In-Reply-To: <1d7609a45e38725d57c2f78b5e437b83b7e49197.camel@coelho.fi> (Luca
        Coelho's message of "Wed, 03 Jul 2019 11:14:52 +0300")
Message-ID: <87d0irqr2l.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Wed, 2019-07-03 at 11:10 +0300, Luca Coelho wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>> 
>> On older NICs, we occasionally see issues with A-MSDU support,
>> where the commands in the FIFO get confused and then we see an
>> assert EDC because the next command in the FIFO isn't TX.
>> 
>> We've tried to isolate this issue and understand where it comes
>> from, but haven't found any errors in building the A-MSDU in
>> software.
>> 
>> At least for now, disable A-MSDU support on older hardware so
>> that users can use it again without fearing the assert.
>> 
>> This fixes https://bugzilla.kernel.org/show_bug.cgi?id=203315.
>> 
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> ---
>
> Hi Dave,
>
> This is an important fix for a bug that has been reported by several
> users in bugzilla (and elsewhere).  It fixes FW crashes that disrupt
> throughput and connectivity in general in very popular devices (Intel's
> WiFi 7000 and 8000 series).
>
> I know it's a bit late for v5.2, but if possible, it would be great to
> take this.  Kalle is on vacation, so we agreed that I would send it
> directly to you.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
