Return-Path: <linux-wireless+bounces-16339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1BA9EFD3B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 21:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EDF188C4F2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 20:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA201D63E0;
	Thu, 12 Dec 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FaElVv5t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19031B5336
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034661; cv=none; b=ONFA5xoXO6W4Erx9B1OFaP9/ygetqYiBY735d4rDRWIsuyOHi419VVW1bBRkbEFtKhDoKwcJtiF0E+eT/N+2h3YCGmkwxCBOPsAFozsoY8TkTnvFQfXJXj67w1W0urag40owSkbSIm/kAjkKl8hTiZjV0Q1poRmR5fxAItmtocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034661; c=relaxed/simple;
	bh=nWym5n/Wf6JKNITmyE9lQSEkwprphkPbE34RpZqiBhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FUm0X2YqMe/ixAmpMkvaZWjtuz6gAuujfRt1sxi4qSS6SEb9QNAhtFS6zhQLs3O07PisS1UqAjdbRxLHl41UcO9USRvwbvrUuQaFPbZWGrCtg70hBszVGYwim+YmZ7secOWZdvCTI6dtYcsdmtUeLUsQsvBeJfjSN+mJWMymwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FaElVv5t; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728ec840a8aso1171920b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 12:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734034659; x=1734639459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cVnndxdnod3A+Ruq3XCNZDJmnImxvPgYtgRgRLmBIQw=;
        b=FaElVv5tKc3gRDA0omy3tWZqylvqi4w/KYeZPYIPQcuA56xP7Xv9KeUx9ruRUQI/SX
         a3Pzx+Zga1VqeR7uPGPpPJQRry5xgnZKEpD6LoTRUDDyn0nkjBmAaVJ7M6tPPcBtAj97
         5OS8a1sNsGXrxtX3XDBVLTQ2uSr6m+P5fTZa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034659; x=1734639459;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVnndxdnod3A+Ruq3XCNZDJmnImxvPgYtgRgRLmBIQw=;
        b=JHocetEjio/kZuvPKhXGKAIiaFmEkmBbzjQyoEhqZdd39qVuaxrjcUM1q5rXb14ReZ
         5p8RSsIQNmH4B7bj5zj8q3QToiBcwodkGXs7pv6WWQGNFj3PbgHVTtZW+zAXxjdSGCQ8
         4qINJgGAC2AICryBTmIe0vERMmstBdMowYdsKFh7q+tfCb5VdB62JGURvb5RdjwFPUmW
         tBghJETJKP+xN3k2Svivy1Ykdvcs3g0wEyHeZ36tIGsTXeu1egdXhMJiuGKauc7xP7tp
         sD0LvY9tPiwKPHBAPuYRG7X2IapXWGqT/NESHolsQh7cHS1DIOANMvnkFHz4pLxqTbmT
         78bw==
X-Forwarded-Encrypted: i=1; AJvYcCVGq9kxQ1sUbH6mUKD9UDNs9rqKbewethWQiVztA1QkgOAN8yts3voRLO2tQ84YIpb77YpRc3zTdymG0acM3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbTPVrrmf7iIDqydlILpXAXfU1/igLiluI6qeElupaTK+xI90
	2qaAwLy8tT2UgXEkwvu/3ekHwLyRDIrjC7/V8uf9lD22wUXmKgW6UylzlzxEFQ==
X-Gm-Gg: ASbGncsVBdvS0ruMBMo3oBT75y/t3qbF9tpfpoFMoiBSgKA8cmSnvHqk1X4WaDCGwjq
	hsMka5fQ90tyfOJ/zUP0Vk/fI9umDjunSkpHnZaA1zM/Apt1Ss5V1Qtbf3SVR2mRR+E+EBFtO4j
	HasfoFyp6hZq1IMy++J4dx1FLElQWryrRXqXHNNnxx2lVvyPN7X5GUd3jkNnHZxrZRPhOOpE696
	NJ035cw7Vd4emJ/SSsWW0DPcO9n7WEeQYkp/qEuyl+0lq3PE2Fw9Tm6Gk5panwneZOiMIHKGfzE
	LgmaOvW3HR8tNXke1Tq/bZUpThkxhz/E
X-Google-Smtp-Source: AGHT+IGcwDJl6gsdi542HBiEir5XSugjSbwM/GQetZecFSpg9GT27fCcTtjBKlZywvbGFrGmjRPSKg==
X-Received: by 2002:a05:6a00:4386:b0:725:df1a:282 with SMTP id d2e1a72fcca58-729069ac8c6mr2511334b3a.10.1734034659165;
        Thu, 12 Dec 2024 12:17:39 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f27a9854sm7097503b3a.0.2024.12.12.12.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:17:38 -0800 (PST)
Message-ID: <ff9c1192-42b5-4a28-a8c9-31af9765cbff@broadcom.com>
Date: Thu, 12 Dec 2024 21:17:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: KeithG <ys3al35l@gmail.com>, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/2024 3:24 PM, KeithG wrote:
> Based on a hunch that brcmfmac dbug might reveal something, I turned
> it on to see what turned up. I attempted the same as before: using iwd
> to connect to the WPA3 AP.
> 
> [iwd]# station wlan0 connect deskSAE
> Type the network passphrase for deskSAE psk.
> Passphrase: *********
> [iwd]# station wlan0 show
>                                   Station: wlan0
> --------------------------------------------------------------------------------
>    Settable  Property              Value
> --------------------------------------------------------------------------------
>              Scanning              no
>              State                 connecting
>              Connected network     deskSAE
>              IPv4 address          169.254.203.147
> 
> the attached log shows brcmfmac debug
> 
> it always shows 'State connecting' never connected.
> 
> Is one of these what is causing it to error out:
> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmware
> error: BCME_UNSUPPORTED (-23)
> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_get
> ifidx=0, name=tdls_sta_info, len=296, err=-52
> ...
> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmware
> error: BCME_BADADDR (-21)
> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_get
> ifidx=0, name=sta_info, len=296, err=-52
> ...
> Dec 09 18:33:32 jackrune kernel: ieee80211 phy0:
> brcmf_cfg80211_get_station: GET STA INFO failed, -52
> 
> I do not know what BCME is.

BCME are the error codes produced by the firmware. Without debug prints 
you will only see a generic error code, ie. -52 (-EBADE). So you always 
see the "Firmware error" message following by the "generic" error 
message. It is not truly generic as it mentions the command name. So the 
above says the command "tdls_sta_info" is unsupported and the mac 
address provided in the "sta_info" command is not found in firmware.

Looking at the log I see periodically:

Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmware 
error: BCME_NOTASSOCIATED (-17)
Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_cmd_data_get 
ifidx=0, cmd=23, len=6, err=-52

According fwil.h the driver sends BRCMF_C_GET_BSSID command. When 
associated is returns the BSSID of your AP. As you are not yet 
associated it fails. Not really related to the external auth procedure I 
think.

The following is more interesting:

Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_cfg80211_external_auth 
Enter
Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_set 
ifidx=0, name=auth_status, len=44
Dec 09 18:32:55 jackrune kernel: brcmutil: data
Dec 09 18:32:55 jackrune kernel: 00000000: 04 00 d8 3a dd 60 a3 0c 07 00 
00 00 64 65 73 6b  ...:.`......desk
Dec 09 18:32:55 jackrune kernel: 00000010: 53 41 45 00 00 00 00 00 00 00 
00 00 00 00 00 00  SAE.............
Dec 09 18:32:55 jackrune kernel: 00000020: 00 00 00 00 00 00 00 00 00 00 
00 00              ............
Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_isr Enter
Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_bus_rxctl resumed 
on rxctl frame, got 72 expected 72
Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmware 
error: BCME_BADLEN (-24)
Dec 09 18:32:55 jackrune kernel: ieee80211 phy0: 
brcmf_cfg80211_external_auth: auth_status iovar failed: ret=-52

So the "auth_status" command fails and the firmware error code indicates 
the length is invalid. The length of the "auth_status" command as sent 
by the driver to the device is 44 and apparently the firmware expects 
some other length. Here is what I did in my patch:

+static int
+brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
+			struct cfg80211_external_auth_params *params)
+{
+	struct brcmf_if *ifp;
+	struct brcmf_pub *drvr;
+	struct brcmf_auth_req_status_le auth_status;
+	int ret = 0;
+
+	brcmf_dbg(TRACE, "Enter\n");
+
+	ifp = netdev_priv(dev);
+	drvr = ifp->drvr;
+	if (params->status == WLAN_STATUS_SUCCESS) {
+		auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
+	} else {
+		bphy_err(drvr, "External authentication failed: status=%d\n",
+			 params->status);
+		auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_FAIL);
+	}
+
+	memcpy(auth_status.peer_mac, params->bssid, ETH_ALEN);
+	auth_status.ssid_len = cpu_to_le32(min_t(u8, params->ssid.ssid_len,
+						 IEEE80211_MAX_SSID_LEN));
+	memcpy(auth_status.ssid, params->ssid.ssid, auth_status.ssid_len);
+
+	ret = brcmf_fil_iovar_data_set(ifp, "auth_status", &auth_status,
+				       sizeof(auth_status));
+	if (ret < 0)
+		bphy_err(drvr, "auth_status iovar failed: ret=%d\n", ret);
+
+	return ret;
+}

So the type struct brcmf_auth_req_status_le is used for external auth 
request and for auth_status. Maybe for the "auth_status" it only needs a 
subset of fields. Here is the struct declaration:

+/**
+ * struct brcmf_auth_req_status_le - external auth request and status 
update
+ *
+ * @flags: flags for external auth status
+ * @peer_mac: peer MAC address
+ * @ssid_len: length of ssid
+ * @ssid: ssid characters
+ */
+struct brcmf_auth_req_status_le {
+	__le16 flags;
+	u8 peer_mac[ETH_ALEN];
+	__le32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+};

Maybe flags and peer_mac is sufficient? That would be 8 bytes so can you 
try and change brcmf_cyw_external_auth() such that it does:

+	ret = brcmf_fil_iovar_data_set(ifp, "auth_status", &auth_status, 8);

Without firmware source code we can only guess.

Regards,
Arend

> On Mon, Dec 9, 2024 at 8:30 AM KeithG <ys3al35l@gmail.com> wrote:
>>
>> I poked at this a while back and decided to try it again over the weekend.
>>
>> Infineon has released a new firmware:
>> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
>> (be70ab3 CY) FWID 01-95efe7fa
>> it is not in the RPiOS release, yet, but I installed it on a Pi3B+ and
>> decided to give it a try. I have an AP running WPA3 personal on a
>> desktop in the home and can connect to it with my phone as proof that
>> it 'works'.
>>
>> I tried to connect to it once again from the Pi while running this new
>> firmware. It gets closer than last time I checked, but it does not
>> actually negotiate a functional connection.
>> I tried with connman/iwd, NetworkManager/iwd and it gets close, but
>> still errors out. I get a number of these in the iwmon log:
>>
>>> Response: Get Station (0x11) len 4                                  38.439787
>>      Status: Invalid exchange (52)
>>
>> Can I probe this further to assist in diagnosing the cause and
>> potentially help with a solution?
>> The log is attached.
>>
>> Regards,
>>
>> Keith


