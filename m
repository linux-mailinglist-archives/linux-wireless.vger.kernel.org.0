Return-Path: <linux-wireless+bounces-10961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E15947CB0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3DE282079
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E450269;
	Mon,  5 Aug 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="J681+WpS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC139FD8
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867466; cv=pass; b=GxK70Yv7UxasMc1FlblV7q/fo6rpm+6Tf1LpSm0+Eh5MpjiDgeGP5ikLW59ftARTL1D0KBBX8fb7TFaIYhX9fVJjik4IglTGJYmSIbolWKu56xq4D76RCGJ3UCGh4vO/vCqcux875UywI1QYtJUwpkbDnvEV/hm038c2Thl+qV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867466; c=relaxed/simple;
	bh=UKAGPZ8D97H3GvPujo40jLOBk5J7nhgLE8KYJAjYnZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4XQw3UvYhhVeYLBc5M9DQvD3DgCdcmICksFVg3uS7vtI2MAXcV7S/ud5uyka9UPdFSpCTdNMeZaNOaxkU5F/JNozYjR8ILwkZQ84EN9F3depH6T+P0PubdFTB8VsKOwndnV6SzPsLjb+LblBj27Mmpwdu4HKpHQMc1L6G3hptE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=J681+WpS; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1722867457; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UQ7C9tu8k4DrqP4R8+ZZgs2CHS25r+p9mpWyhmKvcxltq7x6/SuMemfW7kb+t72Cm5mOS5D8//g+coWVVvNIDBHKUwltO0He2e6hZEvTLp7GkLKF4ATzIg+nIZM5S5Ff/fUStgWo9d/epbgPvUsvhx245qM5BHwHJCP0mYeSsnY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722867457; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w5aGAOi9m6z9D3oNPjjzTzc19Ivf5XtoiHO0E3SFLqA=; 
	b=XjzUeRiB0aA13/0UQ+9q+kByzOsMz1p1QMsU8iwxtY/dJNgBqEdO/x8sRAABzlITJxqGSDhnVeCqkzKLXfxlw0UQhg1Yvm+xSG1VH7j333xe1r/qIJuamkC2vyTM0rpC4Gqzqr9ZTcXFXWt0sZ5q8m3qPDeDAQ/V6XeIDpscXxw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722867457;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=w5aGAOi9m6z9D3oNPjjzTzc19Ivf5XtoiHO0E3SFLqA=;
	b=J681+WpS09ARx8DEBuwpCn58ZktPqmnLRRMQEM1v5VOM9bXt3xFrXdwRFOEXgRJ/
	UGLF+10va71yUvKYZUguNi2r7zlV5seBBZsA/B+tx0gadiKReuz/K41SfkjV8yakhHM
	DHGTSo+SRawxmlX9mN6OSK6lBfHGd9J0ECxIBwYw=
Received: by mx.zohomail.com with SMTPS id 1722867454475301.10766128068565;
	Mon, 5 Aug 2024 07:17:34 -0700 (PDT)
Message-ID: <fc8659fb-7e86-4d29-8966-1f17383b0efe@xv97.com>
Date: Mon, 5 Aug 2024 22:17:31 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath9k_htc: limit MTU
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org
References: <20240405145211.15185-1-m@xv97.com> <8734nrp4uy.fsf@toke.dk>
Content-Language: en-US
From: Chien Wong <m@xv97.com>
Autocrypt: addr=m@xv97.com; keydata=
 xjMEYrGw+RYJKwYBBAHaRw8BAQdAYXRqCQnACPka63iaZ2Lc9u8qPBNaxew6PdbvpuPvkIXN
 F0NoaWVuIFdvbmcgPG1AeHY5Ny5jb20+wpYEExYIAD4WIQRhWIfCT4U86RkflE5cpYo5+kEi
 rQUCYrGw+QIbAwUJEswDAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBcpYo5+kEirQtx
 AP4uJuD0ufTDXmEotuOUiI+86qWvc3jNsUhWYW8wHN8zEgD8Dli09jo/TsTlfWIXWjIs/6Pp
 b96j9fho6xNpETu8ZgnOOARisbD5EgorBgEEAZdVAQUBAQdArBbkcgnrIZ6XnmGUAA9XYA+i
 tf8afTv75UGa2c0YkwoDAQgHwn4EGBYIACYWIQRhWIfCT4U86RkflE5cpYo5+kEirQUCYrGw
 +QIbDAUJEswDAAAKCRBcpYo5+kEircrLAQC/yXFAHzoG9bnsw+hsiVfEbYMa04UiDEFkTd9Q
 kA+I2gD/VCzYkTizWTiXsbcGhB05Q+mI5tX+ehhtpcrIAaBxnA8=
In-Reply-To: <8734nrp4uy.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 7/30/24 6:10 PM, Toke Høiland-Jørgensen wrote:
> Chien Wong <m@xv97.com> writes:
> 
>> Currently, the length of USB messages sent from host to Wi-Fi dongle is
>> not checked. Without the check, we could crash the firmware.
>>
>> The length limits are determined by _HIFusb_get_max_msg_len_patch()
>> in the firmware code, located in k2_HIF_usb_patch.c and HIF_usb_patch.c
>> of the open-ath9k-htc-firmware project. The limits are 512 and 1600
>> bytes for regout and Wi-Fi TX messages respectively.
>> I'm not sure if the firmware crash is due to buffer overflow if RXing
>> too long USB messages but the length limit is clear and verified.
>> Somebody knowing hardware internals could help.
>>
>> We should try our best not to crash the firmware. Setting the MTU limit
>> will help prevent some too long packets from being generated. However,
>> doing this alone is not enough: monitor interfaces will ignore the
>> limit so other measure should also be taken.
>>
>> It's not easy to choose an optimal limit. The numbers that come to mind
>> include (1)1500, (2)1600 - sizeof overhead of shortest possible frame
>> and so on. For (1), it's too limiting: the device supports longer
>> frames. For (2), it won't filter frames with longer overhead.
>> Why bother considering higher layer protocols? We could just consider
>> the driver layer overhead.
>>
>> How to reproduce a crash:
>> 1. Insert a supported Wi-Fi card
>> 2. Associate to an AP
>> 3. Increase MTU of interface: # ip link set wlan0 mtu 2000
>> 4. Generate some big packets: $ ping <gateway> -s 1600
>> 5. The firmware should crash. If not, repeat step 4.
>>
>> Tested-on: TP-LINK TL-WN722N v1(AR9271)
>> Tested-on: TP-LINK TL-WN821N v3(AR7010+AR9287).
>>
>> Signed-off-by: Chien Wong <m@xv97.com>
> 
> (Sorry for not getting around to looking at this earlier)
> 
>> ---
>>   drivers/net/wireless/ath/ath9k/hif_usb.h      | 3 +++
>>   drivers/net/wireless/ath/ath9k/htc_drv_init.c | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
>> index b3e66b0485a5..f8fd78309829 100644
>> --- a/drivers/net/wireless/ath/ath9k/hif_usb.h
>> +++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
>> @@ -50,6 +50,9 @@ extern int htc_use_dev_fw;
>>   #define ATH_USB_RX_STREAM_MODE_TAG 0x4e00
>>   #define ATH_USB_TX_STREAM_MODE_TAG 0x697e
>>   
>> +#define MAX_USB_REG_OUT_PIPE_MSG_SIZE 512
>> +#define MAX_USB_WLAN_TX_PIPE_MSG_SIZE 1600
> 
> (Sorry for not getting around to looking at this earlier)
> 
>>   /* FIXME: Verify these numbers (with Windows) */
>>   #define MAX_TX_URB_NUM  8
>>   #define MAX_TX_BUF_NUM  256
>> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
>> index 3633f9eb2c55..3fad9cd4b1e6 100644
>> --- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
>> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
>> @@ -760,6 +760,9 @@ static void ath9k_set_hw_capab(struct ath9k_htc_priv *priv,
>>   	hw->extra_tx_headroom = sizeof(struct tx_frame_hdr) +
>>   		sizeof(struct htc_frame_hdr) + 4;
>>   
>> +	hw->max_mtu = MAX_USB_WLAN_TX_PIPE_MSG_SIZE - sizeof(struct tx_frame_hdr)
>> +		- sizeof(struct htc_frame_hdr);
> 
> Shouldn't this be the same as the extra_tx_headroom set above? Not sure
> what the +4 is for in that assignment, but it seems a bit odd to not be
> consistent. Did you verify that an MTU of 1580 works without crashing?
> 
> Maybe this should just be:
> 
> 	hw->max_mtu = MAX_USB_WLAN_TX_PIPE_MSG_SIZE - hw->extra_tx_headroom;
> 
> just to be sure?
> 
> -Toke

>> (Sorry for not getting around to looking at this earlier)

Never mind.

>> (Sorry for not getting around to looking at this earlier)

Sure.

>> Shouldn't this be the same as the extra_tx_headroom set above? Not sure
>> what the +4 is for in that assignment, but it seems a bit odd to not be
>> consistent. Did you verify that an MTU of 1580 works without crashing?
>> 
>> Maybe this should just be:
>> 
>> 	hw->max_mtu = MAX_USB_WLAN_TX_PIPE_MSG_SIZE - hw->extra_tx_headroom;
>> 
>> just to be sure?

The +4 is for the header at the very beginning of the USB packet:
 >/* hif_usb_send_mgmt() in hif_usb.c */
 >	hdr = skb_push(skb, 4);
 >	*hdr++ = cpu_to_le16(skb->len - 4);
 >	*hdr++ = cpu_to_le16(ATH_USB_TX_STREAM_MODE_TAG);

I suppose that the four bytes are consumed by the USB hardware and they 
do not occupy buffer in the firmware. And my experiment proved this.
Unfortunately, setting MTU=1580 alone could not prevent the firmware 
from crashing. The MTU only limits upper layer length, not taking MAC 
overhead into account. That's why we need to take other measures such as
dropping packets before sending via USB, as proposed by my earlier patch.

Regards
Chien Wong

