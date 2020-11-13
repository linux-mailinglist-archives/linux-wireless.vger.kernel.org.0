Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A362B1706
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 09:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgKMIPL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 03:15:11 -0500
Received: from z5.mailgun.us ([104.130.96.5]:52858 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMIPL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 03:15:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605255311; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jp453k9H9xxJe/BWQFNg6tLuvLuyorIwuF4UeGvNSB0=;
 b=El0TrUGLxIdo8c3xthlJ6qzSAbphFyx9njVUaMDz9CMoCDY/pcu5hNM+jw6ZdlG0gChjldLh
 nMfQIcfJKjKzYw6YNOt8YRL5U4wQJcYk+EKgpH2v7cVPmFWdb9tVf8BEsQHmXA5OO2s81n2w
 sUkP6KuZjrYvfQghslah6AK44Wo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fae407424ba9b3b027afe68 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Nov 2020 08:14:44
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F380C433F0; Fri, 13 Nov 2020 08:14:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B041DC433C6;
        Fri, 13 Nov 2020 08:14:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Nov 2020 16:14:43 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, kirtika@google.com,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH v2] mac80211: reject/clear user rate mask if not usable
In-Reply-To: <cfee0b47ad026c74a105d3adf2923357bbc5e96e.camel@sipsolutions.net>
References: <20170308132022.4216-1-johannes@sipsolutions.net>
 <07179008e9369bc81e152009ca85191d@codeaurora.org>
 <5decc452-7b2a-db1d-c5eb-04ab6bb61553@broadcom.com>
 <4b8f37fde23262547edb6ed4635cf89b@codeaurora.org>
 <cfee0b47ad026c74a105d3adf2923357bbc5e96e.camel@sipsolutions.net>
Message-ID: <83dd20def685d303106f285400367b6e@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-13 15:38, Johannes Berg wrote:
> On Fri, 2020-11-13 at 10:08 +0800, Wen Gong wrote:
>> 
>> > Which was the intent of this change, wasn't it?
> 
> Indeed. Permitting this leads to warnings later.
> 
>> We need to set the tx rate to fixed at a single rate, e.g.,
>> 54M/48M/36M... for a test case.
>> I do not want a clear error message, I want to the 54M rate pass/set
>> success to lower wlan driver.
>> Then lower wlan driver can handle it.
> 
> No, that will not happen. You should configure your test AP to actually
> support 54M.
Yes, the AP support 54M, but it is not basic rate, so 
ieee80211_set_bitrate_mask will reject 54M
because fail for check (mask->control[band].legacy & basic_rates).

suppor rates of my AP:
Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
     Tag Number: Supported Rates (1)
     Tag length: 8
     Supported Rates: 6(B) (0x8c)
     Supported Rates: 9 (0x12)
     Supported Rates: 12(B) (0x98)
     Supported Rates: 18 (0x24)
     Supported Rates: 24(B) (0xb0)
     Supported Rates: 36 (0x48)
     Supported Rates: 48 (0x60)
     Supported Rates: 54 (0x6c)

> 
> johannes
