Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B69104E48
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 09:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKUIq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 03:46:28 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:47772
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfKUIq1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 03:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574325986;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=H2LwRHOGZFXT5Nqja6YXpjgeYSHAigz0iR5WesZP3fc=;
        b=atcuJVxic0hyiHhC6U1yiTzzwPN6+2owIND1S3KdmkDbCagqQcsmBb8uRZUiGw8O
        ZVsT7rAzFLINBVdeetedt0QAgcZX+40etVZhW2MaPX3wBHYkoRcJFM3Rn7EqGMrri4d
        flPQgZWVS/v1M+Ly1KLi2mgqR9UoEHcHi+EydoUE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574325986;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=H2LwRHOGZFXT5Nqja6YXpjgeYSHAigz0iR5WesZP3fc=;
        b=EgNwe9KmNDQmANnoUlZNTmg6o1tCMlGvnJ/J9SI2+zLkQX5w1XZre5pBt+TxhVpT
        ZL4kh5vT706MQcbd1MAXYH4nxvL5jw8W+W1LTCcfVHfnQhvOgG1JCwI3cLHIn0hDYB4
        G8Dow1ed5JuuW5Pd6lXNF2oj/VAbYhHLxjStcIcQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Nov 2019 08:46:26 +0000
From:   govinds@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt: bindings: add dt entry flag to skip SCM call
 for msa region
In-Reply-To: <20191114191640.GA8426@bogus>
References: <20191111042508.12628-1-govinds@codeaurora.org>
 <20191111042508.12628-2-govinds@codeaurora.org>
 <20191114191640.GA8426@bogus>
Message-ID: <0101016e8d2424e2-f3db29a3-a31a-4718-bdd2-6d7fb1d5511f-000000@us-west-2.amazonses.com>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.11.21-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Rob,

On 2019-11-15 00:46, Rob Herring wrote:
> On Mon, Nov 11, 2019 at 09:55:07AM +0530, Govind Singh wrote:
>> Add boolean context flag to disable SCM call for statically
>> mapped msa region.
> 
> Can't this be implied by the compatible string?
> 

same soc compatible will be used in older TZ vs new TZ.
Due to this reason I added this.

>> 
>> Signed-off-by: Govind Singh <govinds@codeaurora.org>
>> ---
>>  .../devicetree/bindings/net/wireless/qcom,ath10k.txt          | 4 
>> ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt 
>> b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
>> index 017128394a3e..7ba22918bab7 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
>> @@ -88,6 +88,9 @@ Optional properties:
>>  		    of the host capability QMI request
>>  - qcom,xo-cal-data: xo cal offset to be configured in xo trim 
>> register.
>> 
>> +- qcom,msa_fixed_perm: Boolean context flag to disable SCM call for 
>> statically
>> +		       mapped msa region.
>> +
> 
> s/_/-/
> 
>>  Example (to supply PCI based wifi block details):
>> 
>>  In this example, the node is defined as child node of the PCI 
>> controller.
>> @@ -185,4 +188,5 @@ wifi@18000000 {
>>  		vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
>>  		memory-region = <&wifi_msa_mem>;
>>  		iommus = <&apps_smmu 0x0040 0x1>;
>> +		qcom,msa_fixed_perm;
>>  };
>> --
>> 2.22.0
>> 

BR,
Govind
