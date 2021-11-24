Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F6B45B80A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 11:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhKXKLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 05:11:02 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:44914 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhKXKLB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 05:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637748472; x=1669284472;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=arpLo52aBKnSZk5rRWGwLa11R/6I5OAxKmc9Jdo0OIc=;
  b=OVMv15wJH7kxJQLgzyCPXlQz/gZYiDAEpKVd85Px4N3sC8NndWYky5T3
   KTG3srEQt03Sh/cbqHfLCMm5LcWicnolzMSFhAShImN8yz/6CTEEEbTMU
   GQWhu7VlAhtqp3CyxD0zOFmWH0xAVXHWrVL1pm3ejK4uqa+4HzSvYaCZz
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Nov 2021 02:07:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 02:07:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 24 Nov 2021 02:07:51 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 24 Nov
 2021 02:07:50 -0800
Message-ID: <11bd794a-a888-82ee-b933-e54ca4ab9e8e@quicinc.com>
Date:   Wed, 24 Nov 2021 18:07:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] ath11k: add read variant from SMBIOS for download
 board data
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>,
        Mark Herbert <mark.herbert42@gmail.com>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20211118100033.8384-1-quic_wgong@quicinc.com>
 <163759171706.17469.3004620526954131593.kvalo@codeaurora.org>
 <f237c04d-6574-ec9a-ebca-65d2d9ff9edd@gmail.com>
 <871r3883q9.fsf@codeaurora.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <871r3883q9.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/23/2021 2:06 AM, Kalle Valo wrote:
> Mark Herbert <mark.herbert42@gmail.com> writes:
>
>> Tried this on Dell XPS 13 9310
>>
>> Maybe this patch is good for 6855, but 6390 in Dell seems to be killed
>> completely with it. Reverting it makes things work again.
>>
>> [    5.537034] ath11k_pci 0000:72:00.0: chip_id 0x0 chip_family 0xb
>> board_id 0xff soc_id 0xffffffff
>> [    5.537038] ath11k_pci 0000:72:00.0: fw_version 0x101c06cc
>> fw_build_timestamp 2020-06-24 19:50 fw_build_id
>> [    5.537236] ath11k_pci 0000:72:00.0: failed to fetch board data for
>> bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from
>> ath11k/QCA6390/hw2.0/board-2.bin
>> [    5.537255] ath11k_pci 0000:72:00.0: failed to fetch board-2.bin or
>> board.bin from QCA6390/hw2.0
>> [    5.537257] ath11k_pci 0000:72:00.0: qmi failed to fetch board file: -2
>> [    5.537258] ath11k_pci 0000:72:00.0: failed to load board data file: -2
> Doh, I didn't realise that. I only tested this on my NUC testbox, I
> should have tested this on my XPS 13 9310 as well. Thanks for the
> report!
>
> I think I need to revert this and rethink how to handle the backwards
> compatibility.
ath10k has patches to handle backwards compatibility for this issue, I 
think ath11k can also follow it.

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/drivers/net/wireless/ath?id=c8489668065a283d3027e86e877b103a87f99d22
ath10k: search all IEs for variant before falling back

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/drivers/net/wireless/ath?id=2bc2b87bb35a4d7b022016819fc28ce9e2b13adc
ath10k: add option for chip-id based BDF selection
