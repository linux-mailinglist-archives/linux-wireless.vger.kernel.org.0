Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C3C12CC8E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2019 06:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfL3FHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Dec 2019 00:07:19 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:43696 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbfL3FHT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Dec 2019 00:07:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577682438; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=iUHiDa50ipV5g8yjtiIT6rc5EqqmqjGaHB1Oj0CvJfc=;
 b=fBgsYsZqwx+Rc6STAv5372ybc6Gqg5woAJpe5q+TAZ236Gtr3PGp/8QRIUmyDYNeeIprWheV
 GwvwBZlVr/KOGJvT1Nv5Txwn8LzK+pdDzWX5Jw6DY99yagE0cDZ/7UnWJZ7I52NNLrpXm7Lc
 b7V4x8WTc1sZqXTnqksFxnkaVgE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e098605.7f2ca45e0fb8-smtp-out-n02;
 Mon, 30 Dec 2019 05:07:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BB8A2C433A2; Mon, 30 Dec 2019 05:07:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 315CDC433CB;
        Mon, 30 Dec 2019 05:07:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Dec 2019 10:37:16 +0530
From:   tamizhr@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     ath10k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ath10k: Add new dt entries to identify
 coex support
In-Reply-To: <20191226185132.GA31120@bogus>
References: <1576496415-23064-1-git-send-email-tamizhr@codeaurora.org>
 <20191226185132.GA31120@bogus>
Message-ID: <62b9e7b140a96401469f7075811d0d67@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Rob,

Thanks for your review comments.

>> This adds new dt entries qcom,coexist-support and 
>> qcom,coexist-gpio-pin
>> which will be used by ath10k driver to identify coex support
>> of a hardware and notify wifi firmware the gpio pin number.
>> This pin number information is needed for the hardware QCA4019.
>> 
>> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 6 
>> ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt 
>> b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
>> index 0171283..a41e936 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
>> @@ -87,6 +87,10 @@ Optional properties:
>>  	Definition: Quirk specifying that the firmware expects the 8bit 
>> version
>>  		    of the host capability QMI request
>>  - qcom,xo-cal-data: xo cal offset to be configured in xo trim 
>> register.
>> +- qcom,coexist-support : should contain eithr "0" or "1" to indicate 
>> coex
>> +			 support by the hardware.
>> +- qcom,coexist-gpio-pin : gpio pin number  information to support 
>> coex
>> +			  which will be used by wifi firmware.
> 
> What combinations of these 2 properties are valid?
> 
> Is qcom,coexist-gpio-pin required for coexist support? If so then it
> alone should be enough to enable/disable coexist.
> 
qcom,coexist-gpio-pin is required for QCA4019 devices. And other ath10k 
devices doesn't required that value.
So only added two fields to enable/disable coexist and another for 
notifying the gpio pin info.
>> 
>>  Example (to supply PCI based wifi block details):
>> 
>> @@ -156,6 +160,8 @@ wifi0: wifi@a000000 {
>>  	qcom,msi_addr = <0x0b006040>;
>>  	qcom,msi_base = <0x40>;
>>  	qcom,ath10k-pre-calibration-data = [ 01 02 03 ... ];
>> +	qcom,coexist-support = <1>;
>> +	qcom,coexist-gpio-pin = <0x33>;
>>  };
>> 
>>  Example (to supply wcn3990 SoC wifi block details):
>> --

Thanks,
Tamizh.
