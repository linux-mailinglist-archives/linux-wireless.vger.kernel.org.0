Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392651C4A8B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 01:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgEDXqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 19:46:24 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:61369 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbgEDXqX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 19:46:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588635983; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dKZZ/hAPbwDEOiC8H0xBFIIzVsviiHYPlAkqYm2g84Q=;
 b=YznSQji9N/lWi1u76erOcvrq1sdSRAT4q0Q23eW6QtsgFP3H+M3O/Nj+reFCZsLxOn3wXkH6
 fHrDz9TInf8ZfRoW9ji5nDcvbdJvGQ0YDOvedvedORA7BkcCdDIHlByuNgKQB3q68QvezCW3
 vl5djc7coamFldtIUZsATHMfoj8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb0a944.7f72fd9e7ed8-smtp-out-n03;
 Mon, 04 May 2020 23:46:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA5D2C432C2; Mon,  4 May 2020 23:46:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5435AC433CB;
        Mon,  4 May 2020 23:46:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 May 2020 16:46:12 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
In-Reply-To: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
Message-ID: <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-04 08:41, Markus Theil wrote:
> ath10k currently reports survey results for the last interval between 
> each
> invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, this
> can lead to unexpectedly small results, e.g. when hostapd uses survey
> data and iw survey dump is invoked in parallel. Fix this by returning
> cumulative results, that don't depend on the last invocation. Other
> drivers, e.g. ath9k or mt76 also use this behavior.
> 
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> 

IIRC this was fixed a while ago by below patch. Somehow it never landed 
in ath.git.
Simple one line change is enough.

https://patchwork.kernel.org/patch/10550707/

-Rajkumar
