Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA06279FC
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiKNKFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 05:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiKNKFG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 05:05:06 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DC1EEEC
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 02:03:15 -0800 (PST)
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7am5-1otgxE1K3R-0085nS; Mon, 14 Nov 2022 11:03:01 +0100
Message-ID: <f346cb57-0e9e-2add-dda7-b84dbd03bc37@green-communications.fr>
Date:   Mon, 14 Nov 2022 11:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
References: <20221110153953.22562-1-nicolas.cavallari@green-communications.fr>
 <20221110153953.22562-3-nicolas.cavallari@green-communications.fr>
 <db2bde41-7b89-7e89-ae28-e92b1fe0525b@nbd.name>
Content-Language: en-US
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: [PATCH 2/4] wifi: mt76: mt7915: Fix chainmask calculation on
 mt7915 DBDC
In-Reply-To: <db2bde41-7b89-7e89-ae28-e92b1fe0525b@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZP1dth+O2k9Net40h2QGHzFKbWhtTcRktWhX5j+d8MfnyT/zMQ0
 1D4cWzRRJKwqdf4fADB2/HN0yRPMZRnAqVVoOqhfIGRZFBqRlxV0CRC0C6Cx2B/L4DQMSCc
 WUQexXE8kg/1bG1WeLl4YlaUUEVJEZiChwu1Mi2s6qigGjKkgQdDgBLJVJ1xIi8YR/TCI/B
 KaSnTghsx0t81kAVt2ihA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uabNTczvn/U=:94vovw2+81NBxrWC9lTF6B
 xTDhmf+aaActVnazEfdfe0uX24Bw3EeiV7SFVp2IitEYaBTAk8TY0Q76jhcrC3YS9jys5Psxu
 71W0i4Wj4COwOC9cItwxj0mogVfEPjc+qhIqvIz0kPaoVHhbo4eSwHkNflhaBzxUsX3KT15V9
 raG24lOTgPrZpafKLliE8LaN/LGXgT32CNNwAziyCFdWS96V4BbZje3a4bAEhzaNcbpE6J/rk
 yyq3wXSJSMig9MyfkH7qFwoGxNkmMy0pHuUPoZzcYWGDMZfoT9l3iTrSGvHtp8J2BFZ+svxKH
 DxJbF5jpKwl0ZuZ5N6GyydB8G8ju5Nh3xkZtZeekPxQjjwihbGM/H72PGLHyUW23PjIiB6WoL
 qZj8MHSl7fUzW1XM1dPCbiyTjV5NE+3eLr1uBlfCP8uwQadR3NwADXmOqYteoNx8+JpBM6yw1
 j9N7rjNlxjcMJjb3UMXPH6pqKEeJg7xOc6ROwJnUcq6bXPAw9wNvjYcA0SsL11Oghf1xcwcHa
 EfR3awXV30xHeX1AXP656TkaYlsP/E8qkXAfQaU3dEM+VyqCIhVEluLRWySuatxFp3XU7dEjA
 eiQeV+dVyHEazC1L2XgqcbVvLpb0OmHAvXNcH9DxkbUpuqH84p9bYEDjt+8wEG1UGNoUt5Qgu
 0BFMGHXJZoO5fd4Dwqx0aEToUHLuOTaDn7e7MO36aaWSSCVw62JXKWIeA50Swh0e+GZT6wE+x
 keGLeSnxFrwayh0DPOotnK8P/amsUtc6DdlVnSFm/lY9k2e1D4Nv08mqjzsk4MSws5qOO5lTH
 aJd9AYwrrQSNNYTWdgm0wTdkyyziwQYSiexcHlEWT3UCNJnI2nC3bLeQ27qVa9fXl2zkI9CbP
 Y8aQSP4qfC+Xs7WJk8n0bcFAoT2EUH7uI/XRMGn08/VWLWWxwB0yyyIn9kK4DqyGkFPUn1OmL
 fj4u8RQ6Cu9vhO70kez5Dnt3AtcCzEJ+HGzRzSMIIAUMpOx0tqiSUbbppgEYyKlVFsTyRhkZt
 ho5OggCKc+W/goSti6YgKYALpW+wYmyblROKANj/oid6+W+C7AcW3JLvT+G8WlJtlcBc7Pmpx
 +CsNcJlDaVpsElfq4GfcQWpr+qBcgNpFBJpEfSoZio7DyC4BCMobR9+MJnHarjLr9stk+gvwJ
 86BkaiX0Fm9pOnWowgtHRYbwAeNm27OYpFQzql76Ln2zYzgguvMH60Ed6Ttl2X5Z4ZqIiMddJ
 HQBh09JyfCbLNeUC86XFXlb+0UHxILQjtUlP0UDpNmuANo2l1e8Fq9oISDakVa2U6Y7osI3nM
 33V5Dwy8N8oe7H0GThGY17J5U54ukZlYKRWWw31sf4RHRILVQUs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/11/2022 19:17, Felix Fietkau wrote:
> On 10.11.22 16:39, Nicolas Cavallari wrote:
>> mt7915 does not have a per-band number of chains unlike the other chips,
>> it only has a total number of chains.  Yet the current code would
>> consider the total number as a per-band number.
>>
>> For example, it would report that a 2x2 + 2x2 DBDC card have 4 chains on
>> each band and set chainmask to 0b1111 for the first interface and
>> 0b11110000 for the second.
>>
>> Fixes: 99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
>> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
>> ---
>>    drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
>> index 83bced0c0785..8bb971018a1e 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
>> @@ -194,6 +194,7 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev,
>>    	nss = path;
>>    	if (dev->dbdc_support) {
>>    		if (is_mt7915(&dev->mt76)) {
>> +			path = path / 2;
>>    			nss = FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
>>    					eeprom[MT_EE_WIFI_CONF + 3]);
>>    			if (phy->band_idx)
> This was causing a regression on properly calibrated DBDC cards, where
> the 'path' variable contains the per-band path, not the total path.
> I've folded in the following change to fix your commit:
> 
> [...]

Maybe the commit message need to be changed too, because it contains my wrong 
interpretation of the eeprom field...
