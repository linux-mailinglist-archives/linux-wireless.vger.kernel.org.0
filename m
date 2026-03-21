Return-Path: <linux-wireless+bounces-33626-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDVjJjudvmklUgMAu9opvQ
	(envelope-from <linux-wireless+bounces-33626-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 14:29:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2962E5878
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 14:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB1A300343A
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B4738B142;
	Sat, 21 Mar 2026 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+tKHL90"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467238B149
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774099767; cv=none; b=XmLWxk4MiDSGT2V+PQxB+Or8hPABYcqmDKLjo7CfXCQtH4UPnSizMk4NDjw6lEpHGZ5Wbvj96vNI5AhwjvjzQyULzHfcyWTMpBOZf7Okmc2gsZiKxGFOC++mu11Hwmqj3+775W5by3nq1s7EEWKAtCfb+JnbUWSw2EukZrN1sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774099767; c=relaxed/simple;
	bh=SagBXOpiI3Og3Rhw//EDPel9lQOu2sO8VqDAxqNDqqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJ56f8GGNbU4RU6KAmQmdnjKy35LkMYSvjmlRp75wrYWtnGEzQthsEQaTQxm6YjA43YZqKbjbgQFpqZMDYHeu0+H11G+w7XhCrT6uQIXvrc6CL0bWio0VPFi9eSCRvL22IPB628B6nbYcupdYl304goM2LsWJiq9DhvZgqySu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+tKHL90; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso21507375e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774099763; x=1774704563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSV04C3rPIeMeewJbxP7Yc4wuziQBOaH+buDFgiOCSY=;
        b=S+tKHL904aMeX2CvuywHhaWh/383tAp25EdCc6FaCEciFjLbw/75r0b/o7OCsZ9l0E
         5oFabWFkWab8nwoVi+IIeRRla5nQoT/9CotQMFxgBaduG78xbGDyrwIyBqN6BPWp0BKL
         LJkiWvfq3UQMDrPNDPLJKsRAYWcfkQJ0q2c9zKrd/EHGUrhbGnaOJYURYCbkTPZsCVOn
         Ndx5YDkZ5zqWSQrVeaYQ2FopKFZt7k908qjH2DObIjbKIhycyAwpho/GwljYvzsOh3+j
         Fgpktn+xhRECie65VI0wsKlKEkhunTVhziZ7HkThK5wUdJhgYVwC7tITKJEw11nGgj9P
         OCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774099763; x=1774704563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSV04C3rPIeMeewJbxP7Yc4wuziQBOaH+buDFgiOCSY=;
        b=gPxtdzC3MNCzz0Ak6ohmj19nBJ0IVs7hDpAd/ayb3/aeC/3RMvCxmDMRPCUj1Cv7i/
         dV5HnDCMt0rofTLP5p+s6Fwdp7Wq8/UrmppE4yEycZVb1vjdtZTmx1A90vH6rN569jZX
         HTVPDNOQ1lw9O4ILznqOGg6oPN9IMj6kuAqAn4ZI3EFYd20PR2IK0nkSQHIKpYZN07Sf
         R76KxeFH/jNGtUcnWdN43SG4z4fhKl5MWB1B8Sw4DUvAUhvxuKQWZlY5r8Ulq97BkOPM
         68V+AlMDSsYDLG14A7Yz5n80cGuZTTotpGnhaiInCmRL8V0ySVb/6oe5r9NnxYsH2Ttn
         HyMA==
X-Gm-Message-State: AOJu0YztLI8ZOEa8UeJA57UdHq9wYN+jCqULyC47L1DKOWtDd7XnRU6k
	8ZF6OHo+46XCHkLHTSLr7UqGmFbxvhoj1jqztOP663hSgnttqO8e2lAk
X-Gm-Gg: ATEYQzznDcHECKgk1hKW4+vLJNChaOAiKdCAQKnzCeMGN4KTQlFcUvxMzq8YxVbDG+r
	spaaKgUmKoYXB1TwOqHuPGv0E7vzBiDuileZf4OYEYVEITjnp69SfyyxArOPBH0CUAvhYMJJSAU
	hAnpapDntWlCkmbKeQsitOHnLmNBAxcK/vCfbor0vWJsciUP3C/SH78Nr56Kz6H7XF77OiDG5qU
	R/FnhQEQmEonZx+hHADNb8nts/celSvK8ixnh9mSmj3Qa2MDbo5s8rlls9G9HXmkSQikeJfR9nD
	vsK59ATxteKEuCX1D+/nI2tZVy9+MWpmJXJXzFvfeYcDbMXCYMVf+2oN4emnk+OpRtiAiiXBE0i
	GYhI5v/WxC3/Zw/V08xaFrK0UDpEQqmouftvTHyQeIvJDeDbEElDT9fkUzab/LWZUGjEDoZ14Yd
	ocWL8IG1dSIflyXi2vjVZH+iUERniwk2zGCBabzNQWjNZEEGx+JI2NXrJxB6biXkNdiHjD7UUKi
	cg4u/FxTS5rXgJsLUyQxeV8Wt8CJWtl
X-Received: by 2002:a05:600c:8b26:b0:486:f774:82c8 with SMTP id 5b1f17b1804b1-486ff01d1fcmr87925405e9.28.1774099762770;
        Sat, 21 Mar 2026 06:29:22 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48705135631sm44434265e9.15.2026.03.21.06.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 06:29:22 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w3wLf-000000007Jt-2XPL;
	Sat, 21 Mar 2026 14:29:21 +0100
Message-ID: <52b60edf-c571-426d-947c-11654f09224c@gmail.com>
Date: Sat, 21 Mar 2026 14:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] carlfw: add stability fixes for AR9170 USB adapters
To: iamdevnull <mas-i@hotmail.de>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org
References: <AM7PPF5613FA0B6784EE6B1CE5A663476329441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6784EE6B1CE5A663476329441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33626-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.de,googlemail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hotmail.de:email]
X-Rspamd-Queue-Id: 0F2962E5878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 10:11 AM, iamdevnull wrote:
> From: Masi Osmani <mas-i@hotmail.de>
> 
> Five targeted fixes for stability issues observed on AR9170 USB hardware
> (AVM Fritz!WLAN USB Stick N) during extended operation:
> 
> 1. cam.c: Add timeout to CAM busy-wait loops. The original infinite
>     loops block the entire SH-2 processor if the MAC CAM engine stalls,
>     making the firmware unresponsive to USB commands. Add a 10000-cycle
>     timeout to prevent firmware lockup.

Hmm. The firmware sets up a watchdog (hardware timer). It barks (as in: it triggers
the reset vector) when not serviced.

Have you observed that the CAM busy-wait loops can prevent even the watchdog
to go off?


> 2. main.c (tally): Use hardware cycle counter AR9170_MAC_REG_CHANNEL_BUSY
>     for CCA busy time instead of single-bit polling via AR9170_MAC_BACKOFF_CCA.
>     The register is a read-and-clear counter like AR9170_MAC_REG_RX_TOTAL,
>     giving accurate channel utilization data to the driver's survey.


There were reasons why this was chosen. But sure, we can decide if it was a good one
or not.

You see, the problem with AR9170_MAC_REG_CHANNEL_BUSY... that there's also EXT_BUSY
#define AR9170_MAC_REG_CHANNEL_BUSY             (AR9170_MAC_REG_BASE + 0x6e8)
#define AR9170_MAC_REG_EXT_BUSY                 (AR9170_MAC_REG_BASE + 0x6ec)

Don't you need to do something (add it to the other channel struct) when in HT40 mode?
What would this look like?

The other reason was, that I don't know of any hardware counter that keeps track of
the tx-time (counter when hardware is transmitting).

I don't think we should let the hardware run the busy tally but let the software trying
to keep up and do the tx-transmit time tally (from my test back then, it couldn't).

So, we would need to remove the AR9170_MAC_BACKOFF_TX_PE together with fw.tally.tx_time.
And then you loose hostapd's automatic channel selection:
https://wireless.docs.kernel.org/en/latest/en/users/documentation/acs.html
(as it needs tx_time)

> 3. rf.c: On AGC calibration timeout, disable the baseband via
>     AR9170_PHY_ACTIVE_DIS so the driver sees a clean failure instead of
>     operating with a half-initialized PHY that produces corrupted frames.

Sure, if you can make this in a separate commit. I'll merge it.

> 
> 4. wlan.c (RX overrun): Lower the MAC reset threshold from 100% frame
>     loss to >50% frame loss. The original check (overruns == total) only
>     triggered at complete RX blindness, leaving the adapter nearly
>     non-functional at 95% loss without any recovery.

Sure, why not.

> 
> 5. wlan.c (PSM wake): After rf_psm() transitions from PHY_OFF to
>     PHY_ON, re-trigger TX DMA for queued frames. While the PHY was off,
>     hardware could not transmit and DMA trigger bits were consumed
>     without effect.

Yeah, no real surprise here. That said, I to this day disable PS

> 
> 6. wlantx.c: Move wlan_tx_ampdu_reset() after retry queue drain to
>     prevent clearing AMPDU state before retransmission completes.

Sure.

> 
> 7. usb/main.c: Implement usb_warm_reset() for USB bus reset handling.
>     Unlike reboot() which destroys USB PHY state requiring re-plug,
>     warm reset preserves the USB connection and jumps to start() for
>     full firmware re-init. Includes WLAN MAC, DMA, baseband, and PTA
>     reset with BB_WARM_RESET to prevent PHY lockups after repeated
>     warm resets.

The reason why reboot get called was that there seems to be some special
sauce in the sticks bootcode that could get wedged/stalled endpoints to
function again. I believe there's more magic involved which is not implemented
in the carl9170fw, that is necessary for this. One hint might be that I removed the
code that did usb1.1 <-> usb2.0 switching. This was because the original ar9170 was
such a #define nest that I didn't want to touch and the stick seemed fine without it.
(But then, I never observed usb1.1 <-> usb2.0 switching with the original otus driver
+firmware)


Cheers,
Christian

> Tested on AVM Fritz!WLAN N (AR9170, AR9001U) with kernel 6.18.12.
> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   carlfw/src/cam.c    | 17 +++++++----
>   carlfw/src/main.c   |  7 ++++-
>   carlfw/src/rf.c     |  9 ++++++
>   carlfw/src/wlan.c   | 33 +++++++++++++++------
>   carlfw/src/wlantx.c |  3 +-
>   carlfw/usb/main.c   | 63 +++++++++++++++++++++++++++++++++++++++--
>   6 files changed, 113 insertions(+), 19 deletions(-)
> 
> diff --git a/carlfw/src/cam.c b/carlfw/src/cam.c
> index 44cbddd..5273031 100644
> --- a/carlfw/src/cam.c
> +++ b/carlfw/src/cam.c
> @@ -42,31 +42,36 @@ static void enable_cam_user(const uint16_t userId)
>   		orl(AR9170_MAC_REG_CAM_ROLL_CALL_TBL_H, (((uint32_t) 1) << (userId - 32)));
>   }
> 
> +#define CAM_TIMEOUT	10000
> +
>   static void wait_for_cam_read_ready(void)
>   {
> -	while ((get(AR9170_MAC_REG_CAM_STATE) & AR9170_MAC_CAM_STATE_READ_PENDING) == 0) {
> -		/*
> -		 * wait
> -		 */
> +	unsigned int timeout = CAM_TIMEOUT;
> +
> +	while (((get(AR9170_MAC_REG_CAM_STATE) & AR9170_MAC_CAM_STATE_READ_PENDING) == 0) &&
> +	       timeout--) {
> +		/* wait */
>   	}
>   }
> 
>   static void wait_for_cam_write_ready(void)
>   {
> -	while ((get(AR9170_MAC_REG_CAM_STATE) & AR9170_MAC_CAM_STATE_WRITE_PENDING) == 0) {
> -		/*
> -		 * wait some more
> -		 */
> +	unsigned int timeout = CAM_TIMEOUT;
> +
> +	while (((get(AR9170_MAC_REG_CAM_STATE) & AR9170_MAC_CAM_STATE_WRITE_PENDING) == 0) &&
> +	       timeout--) {
> +		/* wait */
>   	}
>   }
> 
>   static void HW_CAM_Avail(void)
>   {
> +	unsigned int timeout = CAM_TIMEOUT;
>   	uint32_t tmpValue;
> 
>   	do {
>   		tmpValue = get(AR9170_MAC_REG_CAM_MODE);
> -	} while (tmpValue & AR9170_MAC_CAM_HOST_PENDING);
> +	} while ((tmpValue & AR9170_MAC_CAM_HOST_PENDING) && timeout--);
>   }
> 
>   static void HW_CAM_Write128(const uint32_t address, const uint32_t *data)
> diff --git a/carlfw/src/main.c b/carlfw/src/main.c
> index 8c13bf8..addc883 100644
> --- a/carlfw/src/main.c
> +++ b/carlfw/src/main.c
> @@ -94,11 +94,16 @@ static void tally_update(void)
> 
>   		fw.tally.active += delta;
> 
> +		/*
> +		 * Use HW cycle counter for CCA busy time instead of
> +		 * single-bit polling. AR9170_MAC_REG_CHANNEL_BUSY is
> +		 * a read-and-clear counter like AR9170_MAC_REG_RX_TOTAL.
> +		 */
> +		fw.tally.cca += get(AR9170_MAC_REG_CHANNEL_BUSY);
> +
>   		boff = get(AR9170_MAC_REG_BACKOFF_STATUS);
>   		if (boff & AR9170_MAC_BACKOFF_TX_PE)
>   			fw.tally.tx_time += delta;
> -		if (boff & AR9170_MAC_BACKOFF_CCA)
> -			fw.tally.cca += delta;
>   	}
>   #endif /* CONFIG_CARL9170FW_RADIO_FUNCTIONS */
>   	fw.tally_clock = time;
> diff --git a/carlfw/src/rf.c b/carlfw/src/rf.c
> index 5e8d3d8..d695742 100644
> --- a/carlfw/src/rf.c
> +++ b/carlfw/src/rf.c
> @@ -190,6 +190,15 @@ static uint32_t rf_init(const uint32_t delta_slope_coeff_exp,
> 
>   	ret = AGC_calibration(finiteLoopCount);
> 
> +	if (ret) {
> +		/*
> +		 * Calibration timed out — PHY is in an undefined state.
> +		 * Disable baseband so the driver sees a clean failure
> +		 * instead of operating with a half-initialized PHY.
> +		 */
> +		set(AR9170_PHY_REG_ACTIVE, AR9170_PHY_ACTIVE_DIS);
> +	}
> +
>   	set_channel_end();
>   	return ret;
>   }
> diff --git a/carlfw/src/wlan.c b/carlfw/src/wlan.c
> index 4e73a2b..7a01b09 100644
> --- a/carlfw/src/wlan.c
> +++ b/carlfw/src/wlan.c
> @@ -77,7 +77,13 @@ static void wlan_check_rx_overrun(void)
>   	fw.tally.rx_total += total = get(AR9170_MAC_REG_RX_TOTAL);
>   	fw.tally.rx_overrun += overruns = get(AR9170_MAC_REG_RX_OVERRUN);
>   	if (unlikely(overruns)) {
> -		if (overruns == total) {
> +		/*
> +		 * Trigger MAC reset when more than half of received
> +		 * frames are dropped.  The original check (overruns ==
> +		 * total) only fired at 100 % loss, leaving the adapter
> +		 * nearly blind at 95 % loss without any recovery.
> +		 */
> +		if (total && overruns > (total >> 1)) {
>   			DBG("RX Overrun");
>   			fw.wlan.mac_reset++;
>   		}
> @@ -100,10 +106,33 @@ static void handle_pretbtt(void)
>   	fw.wlan.cab_flush_time = get_clock_counter();
> 
>   #ifdef CONFIG_CARL9170FW_RADIO_FUNCTIONS
> -	rf_psm();
> +	{
> +		unsigned int prev_phy_state = fw.phy.state;
> +
> +		rf_psm();
> +
> +		/*
> +		 * After PSM wake, re-trigger TX DMA for queued frames.
> +		 * While the PHY was off, the hardware could not transmit
> +		 * and DMA trigger bits were consumed without effect.
> +		 */
> +		if (prev_phy_state == CARL9170_PHY_OFF &&
> +		    fw.phy.state == CARL9170_PHY_ON) {
> +			int i;
> +			uint32_t trigger = 0;
> +
> +			for (i = AR9170_TXQ0; i <= AR9170_TXQ_SPECIAL; i++) {
> +				if (!queue_empty(&fw.wlan.tx_queue[i]))
> +					trigger |= BIT(i);
> +			}
> +
> +			if (trigger)
> +				wlan_trigger(trigger);
> +		}
> 
> -	send_cmd_to_host(4, CARL9170_RSP_PRETBTT, 0x00,
> -			 (uint8_t *) &fw.phy.psm.state);
> +		send_cmd_to_host(4, CARL9170_RSP_PRETBTT, 0x00,
> +				 (uint8_t *) &fw.phy.psm.state);
> +	}
>   #endif /* CONFIG_CARL9170FW_RADIO_FUNCTIONS */
>   }
> 
> diff --git a/carlfw/src/wlantx.c b/carlfw/src/wlantx.c
> index a8d0952..2db111e 100644
> --- a/carlfw/src/wlantx.c
> +++ b/carlfw/src/wlantx.c
> @@ -471,11 +471,10 @@ void handle_wlan_tx_completion(void)
>   			}
>   		}
> 
> -		wlan_tx_ampdu_reset(i);
> -
>   		for_each_desc(desc, &fw.wlan.tx_retry)
>   			__wlan_tx(desc);
> 
> +		wlan_tx_ampdu_reset(i);
>   		wlan_tx_ampdu_end(i);
>   		if (!queue_empty(&fw.wlan.tx_queue[i]))
>   			wlan_trigger(BIT(i));
> diff --git a/carlfw/usb/main.c b/carlfw/usb/main.c
> index 4199a21..9147c80 100644
> --- a/carlfw/usb/main.c
> +++ b/carlfw/usb/main.c
> @@ -295,6 +295,63 @@ static void disable_watchdog(void)
>   	set(AR9170_TIMER_REG_WATCH_DOG, 0xffff);
>   }
> 
> +/*
> + * Warm reset: re-initialize firmware without destroying USB PHY state.
> + * This allows the host to re-enumerate the device after a USB bus reset
> + * without requiring a physical re-plug.
> + *
> + * Unlike reboot() which calls turn_power_off() and jump_to_bootcode(),
> + * this preserves the USB connection and jumps directly to start().
> + */
> +static void __noreturn usb_warm_reset(void)
> +{
> +	disable_watchdog();
> +
> +	/* Disable baseband to stop PHY activity */
> +	set(AR9170_PHY_REG_ACTIVE, AR9170_PHY_ACTIVE_DIS);
> +
> +	/* Stop WLAN DMA */
> +	set(AR9170_MAC_REG_DMA_TRIGGER, 0);
> +
> +	/* Stop USB DMA without full power-off */
> +	andl(AR9170_USB_REG_DMA_CTL, ~(AR9170_USB_DMA_CTL_ENABLE_TO_DEVICE |
> +					AR9170_USB_DMA_CTL_ENABLE_FROM_DEVICE));
> +
> +	/* Reset PTA component */
> +	orl(AR9170_PTA_REG_DMA_MODE_CTRL, AR9170_PTA_DMA_MODE_CTRL_RESET);
> +	andl(AR9170_PTA_REG_DMA_MODE_CTRL, ~AR9170_PTA_DMA_MODE_CTRL_RESET);
> +
> +	/* Reset MAC power state */
> +	set(AR9170_MAC_REG_POWER_STATE_CTRL,
> +	    AR9170_MAC_POWER_STATE_CTRL_RESET);
> +
> +	/*
> +	 * Hardware reset: WLAN MAC, DMA engine, and baseband.
> +	 * Without this, the PHY/RF can lock up after repeated
> +	 * warm resets, causing -ETIMEDOUT on register writes
> +	 * and cascading driver reloads (phy0 -> phy29 -> crash).
> +	 *
> +	 * BB_WARM_RESET resets PHY logic while preserving
> +	 * calibration-friendly state. start() -> init() will
> +	 * reconfigure everything via the driver anyway.
> +	 */
> +	set(AR9170_PWR_REG_RESET, AR9170_PWR_RESET_COMMIT_RESET_MASK |
> +				  AR9170_PWR_RESET_WLAN_MASK |
> +				  AR9170_PWR_RESET_DMA_MASK |
> +				  AR9170_PWR_RESET_BB_WARM_RESET);
> +	set(AR9170_PWR_REG_RESET, 0x0);
> +
> +	/* Clean DMA memory */
> +	memset(&dma_mem, 0, sizeof(dma_mem));
> +
> +	/* Clear firmware state */
> +	memset(&fw, 0, sizeof(fw));
> +
> +	/* Re-enter firmware from start() which does full init
> +	 * and sends CARL9170_RSP_BOOT to the host. */
> +	start();
> +}
> +
>   void __noreturn reboot(void)
>   {
>   	disable_watchdog();
> @@ -377,7 +434,7 @@ static void usb_handler(uint8_t usb_interrupt_level1)
>   		if (usb_interrupt_level2 & AR9170_USB_INTR_SRC7_USB_RESET) {
>   			usb_reset_ack();
>   			usb_reset_eps();
> -			reboot();
> +			usb_warm_reset();
>   		}
> 
>   		if (usb_interrupt_level2 & AR9170_USB_INTR_SRC7_USB_SUSPEND) {
> @@ -409,7 +466,7 @@ static void usb_handler(uint8_t usb_interrupt_level1)
>   			fw.suspend_mode = CARL9170_HOST_AWAKE;
>   			set(AR9170_USB_REG_WAKE_UP, 0);
> 
> -			reboot();
> +			usb_warm_reset();
>   		}
>   	}
>   }


