Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9021445D692
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 09:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353673AbhKYJAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 04:00:38 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:63706 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350560AbhKYI6f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 03:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637830525; x=1669366525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z3g1A+B4HFgN1D6D4RhvKdwkVZPZE8FLFY/pG4A5vP0=;
  b=cx0kAu3qlIh5vNMqhDb8dX3N01kupQTaqGtyNFi1WcW7AUq3wMZoXMSi
   YzxcAzJGDatfJoqR7LOUf4EUZt4unvz3rqzp2fP1ZTPpHPj+FANSS5+ub
   7shKmXqPlFY+PCFQPD2iKfDYAUbpTb7ZTav6DQsyIw7aX5pBXKSinj9x8
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 25 Nov 2021 00:55:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 00:55:25 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:24 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 25 Nov
 2021 00:55:23 -0800
Message-ID: <312f32ac-0b43-df3e-bb0a-316183cffa9d@quicinc.com>
Date:   Thu, 25 Nov 2021 16:55:18 +0800
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
 <871r3883q9.fsf@codeaurora.org> <87fsrl6g7q.fsf@codeaurora.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87fsrl6g7q.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

I have sent v3 of "ath11k: add read variant from SMBIOS for download 
board data", it fixed the backwards compatibility issue.

https://patchwork.kernel.org/project/linux-wireless/list/?series=585697

Wen Gong (2):
   ath11k: add fallback board name without variant while searching 
board-2.bin
   ath11k: add read variant from SMBIOS for download board data

On 11/24/2021 5:44 PM, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> Mark Herbert <mark.herbert42@gmail.com> writes:
>>
>>> Tried this on Dell XPS 13 9310
>>>
>>> Maybe this patch is good for 6855, but 6390 in Dell seems to be killed
>>> completely with it. Reverting it makes things work again.
>>>
>>> [    5.537034] ath11k_pci 0000:72:00.0: chip_id 0x0 chip_family 0xb
>>> board_id 0xff soc_id 0xffffffff
>>> [    5.537038] ath11k_pci 0000:72:00.0: fw_version 0x101c06cc
>>> fw_build_timestamp 2020-06-24 19:50 fw_build_id
>>> [    5.537236] ath11k_pci 0000:72:00.0: failed to fetch board data for
>>> bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from
>>> ath11k/QCA6390/hw2.0/board-2.bin
>>> [    5.537255] ath11k_pci 0000:72:00.0: failed to fetch board-2.bin or
>>> board.bin from QCA6390/hw2.0
>>> [    5.537257] ath11k_pci 0000:72:00.0: qmi failed to fetch board file: -2
>>> [    5.537258] ath11k_pci 0000:72:00.0: failed to load board data file: -2
>> Doh, I didn't realise that. I only tested this on my NUC testbox, I
>> should have tested this on my XPS 13 9310 as well. Thanks for the
>> report!
>>
>> I think I need to revert this and rethink how to handle the backwards
>> compatibility.
> Revert sent:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20211124094316.9096-1-kvalo@codeaurora.org/
>
