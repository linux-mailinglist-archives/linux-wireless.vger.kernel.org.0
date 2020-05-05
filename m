Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5A1C6061
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgEESpY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 14:45:24 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:27592 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbgEESpY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 14:45:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588704324; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VIAL5M0Rlq1AceCBJqXZI0N+V75qDS1DsnYTy7Bp0gg=;
 b=TD5YbeZtYg/DJXVFcsxgZByKemQNwNICEJzhc35sLMn1A2yYfB7kcZshec9vWJgosyJ1alh/
 dwWed2rsfciBTU+69mZPkBInJVeno0lR2b8qcIipu3BKP5CjbR2uEAFEF+ECLOAzI/VRP/O4
 dv2igOSyZ5X+EsC2jskIMRF4Qjc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb1b43c.7feb205a1848-smtp-out-n02;
 Tue, 05 May 2020 18:45:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6EA3C433BA; Tue,  5 May 2020 18:45:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60356C433CB;
        Tue,  5 May 2020 18:45:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 11:45:16 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        ath10k@lists.infradead.org, kvalo@codeaurora.org
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
In-Reply-To: <5194473.9tBAi8KRnL@bentobox>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <2335594.cnkAv9Vaq7@bentobox> <1845755.pTfhzBy2qg@bentobox>
 <5194473.9tBAi8KRnL@bentobox>
Message-ID: <a94c7a62622d46fcb01504027a9374a7@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-05 00:55, Sven Eckelmann wrote:
> On Tuesday, 5 May 2020 09:49:46 CEST Sven Eckelmann wrote:
> [...]
>> See also https://patchwork.kernel.org/patch/9701459/
> 
> And I completely forgot about this one:
> https://patchwork.kernel.org/patch/10417673/
> 
_Me_too_ :) Hope this change is not needed when all drivers report
accumulated values.

-Rajkumar
