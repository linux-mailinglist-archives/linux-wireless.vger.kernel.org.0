Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5809D2624BC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 04:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIICEt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 22:04:49 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:40216
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbgIICEr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 22:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599617086;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=7KuW8jIV4frpgAgS2iHdjEArRv6YShrzR1PwwM73iQs=;
        b=b3943FQc5MeLOGO0+2205+MdfF/kHd9hnHz33zU6vSfJ7D9iRMV1MP4M/kHWSfcb
        3bONJE7OSeekV4wt4IupfCsPj7d/UN60JfX53A728zmoAlbdwXLVIZMHOVLH/Cl+tHM
        arCaOz21e5no1OI/yRABC6A+Etnclr+cKMapewYA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599617086;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=7KuW8jIV4frpgAgS2iHdjEArRv6YShrzR1PwwM73iQs=;
        b=D2zgUAftqhUQP5DpkTRTFDTVlWsHErUI5KPo4yMGvOMSK327xgBQTPiO7YmqTrka
        poQCuIhRRq+kvvzvjYSGD4a1KLU5wz3gabDTauAcvxKzPzRWkcoa8lh+uOUZGWD5x/P
        CVbbZdGLJIHjqe2v48K/tFfSfBhE7Yiuc/Xa81+c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 9 Sep 2020 02:04:46 +0000
From:   Zhi Chen <zhichen@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH,v4] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
In-Reply-To: <79a88865-6df5-e7a4-deb6-6025cc9d87e4@candelatech.com>
References: <1578976521-6104-1-git-send-email-zhichen@codeaurora.org>
 <79a88865-6df5-e7a4-deb6-6025cc9d87e4@candelatech.com>
Message-ID: <01010174709bb20f-026d2835-333e-43b0-aaa7-5f1ff46332b1-000000@us-west-2.amazonses.com>
X-Sender: zhichen@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.09-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ben,
   Thanks for your information. The DMA issue is host related. We never 
hit this issue with X86 platform. And it was only seen in stress cases 
with 50+ STAs(association and disassociation repeatedly). What's the 
host platform you are using? And how was the issue reproduced?

Thanks,
Zhi

On 2020-09-09 01:48, Ben Greear wrote:
> Hello,
> 
> Just FYI:  I added this patch to my ath10k-ct driver, and a user
> reported it causes
> regressions on his particular 9888 system when using ath10k-ct wave-2 
> firmware:
> 
> [   21.204868] ath10k_pci 0000:00:00.0: qca9888 hw2.0 target
> 0x01000000 chip_id 0x00000000 sub 0000:0000
> [   21.214437] ath10k_pci 0000:00:00.0: kconfig debug 0 debugfs 1
> tracing 0 dfs 1 testmode 0
> [   21.233298] ath10k_pci 0000:00:00.0: firmware ver
> 10.4b-ct-9888-tH-13-8c5b2baa2 api 5 features
> mfp,peer-flow-ctrl,txstatus-noack,wmi-10.x-CT,ratemask-CT,regdump-CT,txrate-CT,flush-all-CT,pingpong-CT,ch-regs-CT,nop-CT,htt-mgt-CT,set-special-CT,no-bmiss-CT,tx-rc-CT,cust-stats-CT,txrate2-CT,beacon-cb-CT,wmi-block-ack-CT,wmi-bcn-rc-CT
> crc32 a00b5f36
> [   21.596684] ath10k_pci 0000:00:00.0: board_file api 2 bmi_id 0:20
> crc32 5bb32c02[   23.546156] ath10k_pci 0000:00:00.0: unsupported HTC
> service id: 1536
> 
> I'll revert this for the 9888 chipset (at least) in my driver,
> possibly you need to do similar.
> 
> https://github.com/greearb/ath10k-ct/issues/153
> 
> Thanks,
> Ben
> 
> On 1/13/20 8:35 PM, Zhi Chen wrote:
>> This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
>> PCIe hung issue was observed on multiple platforms. The issue was 
>> reproduced
>> when DUT was configured as AP and associated with 50+ STAs.
>> 
>> For QCA9984/QCA9888, the DMA_BURST_SIZE register controls the AXI 
>> burst size
>> of the RD/WR access to the HOST MEM.
>> 0 - No split , RAW read/write transfer size from MAC is put out on bus
>>      as burst length
>> 1 - Split at 256 byte boundary
>> 2,3 - Reserved
>> 
>> With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary 
>> when
>> issue happened. It broke PCIe spec and caused PCIe stuck. So revert
>> the default value from 0 to 1.
>> 
>> Tested:  IPQ8064 + QCA9984 with firmware 10.4-3.10-00047
>>           QCS404 + QCA9984 with firmware 10.4-3.9.0.2--00044
>>           Synaptics AS370 + QCA9888  with firmware 10.4-3.9.0.2--00040
>> 
>> Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
>> ---
>> v2: restored 10.2 register configuration
>> v3: modified commit message
>> v4: resolved conflicts
>> ---
>>   drivers/net/wireless/ath/ath10k/hw.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath10k/hw.h 
>> b/drivers/net/wireless/ath/ath10k/hw.h
>> index 21b7a2a..775fd62 100644
>> --- a/drivers/net/wireless/ath/ath10k/hw.h
>> +++ b/drivers/net/wireless/ath/ath10k/hw.h
>> @@ -816,7 +816,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
>>     #define TARGET_10_4_TX_DBG_LOG_SIZE		1024
>>   #define TARGET_10_4_NUM_WDS_ENTRIES		32
>> -#define TARGET_10_4_DMA_BURST_SIZE		0
>> +#define TARGET_10_4_DMA_BURST_SIZE		1
>>   #define TARGET_10_4_MAC_AGGR_DELIM		0
>>   #define TARGET_10_4_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK 1
>>   #define TARGET_10_4_VOW_CONFIG			0
>> 
