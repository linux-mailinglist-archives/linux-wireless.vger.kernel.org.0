Return-Path: <linux-wireless+bounces-18781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6DA3123D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 17:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05B11646ED
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406BA260A2D;
	Tue, 11 Feb 2025 16:58:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86F25EFA6
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293114; cv=none; b=Zl5+yATBmgNgZuVra+fCp5scGOd3y5pafAasL5u+S+QdmW526MSFAD+7ebItKBgsV/GGw+mFFwBK2A5yKlhaX23sGayhfBsEOPAKPykPYwgFMT8U1+GNvkhvdsYJxTr4AplCdQ5OGlfaniHq8igjj7YgkelAAV6os3xZRDC4HR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293114; c=relaxed/simple;
	bh=OZmNqpZ10Voej+d4Bg530AYk4emkDsFDLW+0+UeNFPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3SKjplP4OyRyynDIw9nBW3bf6a5Om3/5wUKsrwQkqNYOK+HQxWyrJTHEJ6+vA8Z7UNNLSt6oeXhqtzyEvlV5I7D5kXW+XDXgdMAuNtH+jNMgYaInjWJ01M+ONDLvTJ0Jzz3gL/oEF3RfgkcDq1uE74XuN3455yqySI18yw8kxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from [IPV6:2003:c5:9713:7790::32b] (p200300C597137790000000000000032b.dip0.t-ipconnect.de [IPv6:2003:c5:9713:7790::32b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C9041FA131;
	Tue, 11 Feb 2025 17:58:23 +0100 (CET)
Message-ID: <93cb3283-3fb3-47be-841b-1f8586c06216@simonwunderlich.de>
Date: Tue, 11 Feb 2025 17:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] wifi: intel: incorrect RSSI values on beacons from APs
 using legacy rates
Content-Language: en-US
To: lkp@intel.com, johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc: sw@simonwunderlich.de
References: <20241125164034.2712936-1-ih@simonwunderlich.de>
From: Hamdi Issam <ih@simonwunderlich.de>
In-Reply-To: <20241125164034.2712936-1-ih@simonwunderlich.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have opened a ticket 
(https://community.intel.com/t5/Wireless/wifi-intel-incorrect-RSSI-values-on-beacons-from-APs-using/m-p/1647584#M57080) 
on the intel support community about this issue, but the Linux OS is 
unsupported by them.

Does anyone have any ideas on how to further debug this issue or what 
might be causing it?

Regards,

Issam

On 11/25/24 17:40, Issam Hamdi wrote:
> We identified an issue where the RSSI values for beacons from
> legacy rates AP are incorrect, consistently showing -128.
>
> This issue was identified on the Intel AX210 WiFi chip with
> firmware version "89.202a2f7b.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm"
>
> To reproduce this issue :
>      - Setup an AP with legacy rates on the frequency 2422Mhz
>      - And on the device with Intel AX210 chip run:
>          iw phy0 interface add mon0 type monitor
>          ip link set mon0 up
>          iw dev mon0 set freq 2422
>          tcpdump -i mon0 -v
>
> After debugging, we discovered that the RSSI values become
> correct when a printk() statement is added to the RX path
> in the iwlwifi driver, as shown the patch below.
>
> Alternatively, adding udelay() instead of printk() also corrects
> the incorrect RSSI values; however, this approach leads to
> firmware warnings and errors:
>
> ````
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> @@ -1543,7 +1543,7 @@ restart:
>           }
>
>           IWL_DEBUG_RX(trans, "Q %d: HW = %d, SW = %d\n", rxq->id, r, i);
> -
> +        udelay(500);
>           rxb = iwl_pcie_get_rxb(trans, rxq, i, &join);
>           if (!rxb)
>               goto out;
> ````
>
> Additionally, we found that deleting all existing interfaces on
> the PHY and then creating a monitor interface resolves this issue:
>      iw dev wlan0 interface del   # In case we have wlan0 as the existing interface.
>      iw phy0 interface add mon0 type monitor
>      ip link set mon0 up
>      iw dev mon0 set freq 2422
>
> However, in this case, it will not be possible to execute the scan
> command with the monitor interface to prompt the firmware to
> trigger the country code.
>
> Has anyone encountered this issue before or have any insights
> into the potential root cause ?
>
> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
> ---
>   drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> index afb88eab8174..b0ce71e6260b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> @@ -1544,6 +1544,8 @@ static int iwl_pcie_rx_handle(struct iwl_trans *trans, int queue, int budget)
>   
>   		IWL_DEBUG_RX(trans, "Q %d: HW = %d, SW = %d\n", rxq->id, r, i);
>   
> +		printk(KERN_DEBUG "Got new packet\n");
> +
>   		rxb = iwl_pcie_get_rxb(trans, rxq, i, &join);
>   		if (!rxb)
>   			goto out;
>
> base-commit: 2b94751626a6d49bbe42a19cc1503bd391016bd5

