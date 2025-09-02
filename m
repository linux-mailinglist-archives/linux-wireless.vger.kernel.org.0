Return-Path: <linux-wireless+bounces-26923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299ACB3F6CC
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 09:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0643B7E8A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 07:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571222E610B;
	Tue,  2 Sep 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sbNlwxxA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SsKLQ/sf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD42E2F05
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798887; cv=none; b=GQEgqAwh2EU92lnJ0NfK6ZdJ3qJYDpxU4ImZoDSxe2jHf5qBhg6eI+iEkWOjVA5MAo2a7KdGKTa7lsSJWfP5iprFtJ3Sf+kFbZmdBDT3uuf9a7/EZSnp2pbqDp/JkArYsXDEnAnOwOk060mWZHUSZ4zgUXwrUoiGonMTMbMfhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798887; c=relaxed/simple;
	bh=PGdAZxIGQ6ZspDjqqmFeoR6uQLyw59xnVj3t4VnvU8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHsmYcPizPSnMavVhWP0RLB+Cm79DsG4z4YSqgwLKt2TmY6Ou92Fhfvk1t3fn2UmdsQN8gvSf1nPFiqLGKT0G1bxE+Yr555MDL7k3ry0vpKaniptwDifZatTpVdZiQFCwvKPSLihyw9w0QZdadiF7UL3cLrZuFqCTnPOJPIEjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sbNlwxxA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SsKLQ/sf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <515e5d08-5315-415a-a406-2493871c76e6@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756798883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7RVvU53wuPDdJbvoIxSKpV2Dw2PmbkTVKRKAFQvzv4=;
	b=sbNlwxxA5zso623cdOyDjXG3Xo6g/alris1nAjkG0o8A1BM6kKg35jpoOBpwa/4KX6Tg2D
	JBcwQ1DujsJyQj3HJONQeVgHorcFKt2rMs9rjMmPoQkJiGv+CCdmtODCgD/DDHH206+p4J
	Z2OytO43DlanyFfjusOL4sT14b8MCllZf6Dcm17AddhQzvogdeTWiHijRb+w7WabuZAx3N
	viTlUxib+3EpsbIQ6ELty8aVKtqQ/nHG2XRwkl5qpvJ4ZyizLz47GRfyjy+Ie9wEbujTFO
	VKLrQiYrAt65wmyWAeZEBiDUwylnFXlPk1UsxuD8dDAObGdSG6MLdu/ylevrcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756798883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7RVvU53wuPDdJbvoIxSKpV2Dw2PmbkTVKRKAFQvzv4=;
	b=SsKLQ/sfrZegcDvOXLNSyQoznwSmfmsEaJBVbW1Z0hbK75SToo3TX4b8YkQfeXSkOXe69F
	XEQ8EWOd2sErIRDw==
Date: Tue, 2 Sep 2025 09:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rtw-next v2] wifi: rtl8xxxu: expose efuse via debugfs
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>
References: <20250901121613.1876109-1-martin.kaistra@linutronix.de>
 <a2bc752666524249b19dfafb7912f6cc@realtek.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <a2bc752666524249b19dfafb7912f6cc@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 02.09.25 um 03:12 schrieb Ping-Ke Shih:
> Martin Kaistra <martin.kaistra@linutronix.de> wrote:
>> The efuse contains the mac address and calibration data. During
>> manufacturing and testing it can be necessary to read and check this
>> data.
>>
>> Add a debugfs interface to make it available to userspace.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>> Changes in v2:
>> - remove unnecessary comment
>> - use debugfs_short_fops
>>
>>   drivers/net/wireless/realtek/rtl8xxxu/core.c | 22 ++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> index 831b5025c6349..aea706f0251d8 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> @@ -1901,6 +1901,27 @@ static void rtl8xxxu_dump_efuse(struct rtl8xxxu_priv *priv)
>>                         priv->efuse_wifi.raw, EFUSE_MAP_LEN, true);
>>   }
>>
>> +static ssize_t read_file_efuse(struct file *file, char __user *user_buf,
>> +                              size_t count, loff_t *ppos)
>> +{
>> +       struct rtl8xxxu_priv *priv = file_inode(file)->i_private;
>> +
>> +       return simple_read_from_buffer(user_buf, count, ppos,
>> +                                      priv->efuse_wifi.raw, EFUSE_MAP_LEN);
>> +}
>> +
>> +static const struct debugfs_short_fops fops_efuse = {
>> +       .read = read_file_efuse,
>> +};
>> +
>> +static void rtl8xxxu_debugfs_init(struct rtl8xxxu_priv *priv)
>> +{
>> +       struct dentry *phydir;
>> +
>> +       phydir = debugfs_create_dir("rtl8xxxu", priv->hw->wiphy->debugfsdir);
>> +       debugfs_create_file("efuse", 0400, phydir, priv, &fops_efuse);
>> +}
>> +
> 
> Could you please try if this would encounter build error without
> CFG80211_DEBUGFS?

Builds and runs without errors when CFG80211_DEBUGFS is disabled:

# ls /sys/kernel/debug/ieee80211/phy0/
rtl8xxxu

I also don't see any build errors when DEBUG_FS is disabled completely.


> 
> Otherwise, looks good to me.
> 
>>   void rtl8xxxu_reset_8051(struct rtl8xxxu_priv *priv)
>>   {
>>          u8 val8;
>> @@ -7974,6 +7995,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>          }
>>
>>          rtl8xxxu_init_led(priv);
>> +       rtl8xxxu_debugfs_init(priv);
>>
>>          return 0;
>>
>> --
>> 2.39.5
> 


