Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9132126417
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 14:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfLSN5j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 08:57:39 -0500
Received: from nbd.name ([46.4.11.11]:36214 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfLSN5i (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 08:57:38 -0500
Received: from pd95fd34f.dip0.t-ipconnect.de ([217.95.211.79] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihwJ7-0000kB-At; Thu, 19 Dec 2019 14:57:37 +0100
Subject: Re: [PATCH 1/2] dt: bindings: net: ath11k: add qcom,board_id
 definition
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20191217164329.4151-1-john@phrozen.org>
 <871rt077d8.fsf@kamboji.qca.qualcomm.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <7052d9eb-412e-e802-52ed-2e1d63a65fe5@phrozen.org>
Date:   Thu, 19 Dec 2019 14:57:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <871rt077d8.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/12/2019 14:49, Kalle Valo wrote:
> John Crispin <john@phrozen.org> writes:
> 
>> We need to be able to define what id the board has allowing us to load the
>> correct definition data. This patch adds the description of the required
>> property.
>>
>> Signed-off-by: John Crispin <john@phrozen.org>
>> ---
>>   .../devicetree/bindings/net/wireless/qcom,ath11k.yaml        | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> index a1717db36dba..c68daf6ad424 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> @@ -142,6 +142,11 @@ properties:
>>           * reg
>>           * reg-names
>>   
>> +  qcom,board_id:
>> +      $ref: /schemas/types.yaml#/definitions/uint32
>> +      description:
>> +        The board id defining what board definition should be loaded
> 
> I think this needs more discussion. This is very tricky to get right, as
> it needs to be extensible and what not. With ath10k we have learned that
> a simple integer is not enough.
> 

I was expecting this, there seems to be an option to add ranges and/or 
enums. I did however fail to find any docs on the schemeas.
	John
