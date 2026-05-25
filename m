Return-Path: <linux-wireless+bounces-36890-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEllEyKkFGqXPAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36890-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 21:33:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F295CE08E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 21:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 514AE3006811
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA3730C164;
	Mon, 25 May 2026 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/XPVRCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28E7E0E8;
	Mon, 25 May 2026 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779737632; cv=none; b=ATnw/XZs0qJt0d8jyw3YA0H6gm7NL9jAkoDvsxXsv+48iN34w2HNP6GOZyoajMmeWYk/qJTp580SriKdt6KWwSaQ29sJwJxNCExWo7Jt9P8dbQ26EpNmp33TjmMHiZ7OI95eZqJkAzV9PY2+x5ksBsTC9PVr2Vxbbzh2HkTaV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779737632; c=relaxed/simple;
	bh=AAvquANotoD1NxY6DEOLjliyQnsOiETlzNdjFBC/J3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF/I50ESqn66eKbNjGTX3WO4xOF4U86BpMIaiVdtkYTM37pzDcJA8p3U0Y2JxnQyhCvVs1KwUnVmmQwAVRMveXigQy326B02KeA7O+0X879Yo6CenY+1c+MAu5ZkwtA+BJOqrp2YLcZoDAAJJVw070Rl5RtfbLltRwkDR7NY9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/XPVRCa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D5A1F000E9;
	Mon, 25 May 2026 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779737630;
	bh=JokBFlG1NQOC7FSPmvWKWB6Uo8QYRkXQi+S3/O/qhl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=v/XPVRCa3grLs8eR8VQ9wHEBy5OhsZfADFnMs44e1kAkWkVh/E7vE4sDQDcWj5Avw
	 FBFCP8CcRcnyOHKvBsKQA5W5Vdpar9G/jOvLw6px4Q2kABlhkNr43KDcetzyrXUYv2
	 PXGE9Msele4IP8ZJ9htk0PIOeKT/uk5O8RQ29BXE=
Date: Mon, 25 May 2026 21:32:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, driver-core@lists.linux.dev,
	johannes@sipsolutions.net, wenjie.tsai@realtek.com,
	mh_chen@realtek.com, charlesl@valvesoftware.com,
	sabae@valvesoftware.com
Subject: Re: [PATCH v2 rtw-next 2/2] wifi: rtw89: usb: add serial_number and
 uuid sysfs attributes for 0x28de:0x2432
Message-ID: <2026052524-ammonia-zeppelin-9edb@gregkh>
References: <20260525085148.35180-1-pkshih@realtek.com>
 <20260525085148.35180-3-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525085148.35180-3-pkshih@realtek.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36890-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valvesoftware.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E1F295CE08E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 04:51:48PM +0800, Ping-Ke Shih wrote:
> From: Johnson Tsai <wenjie.tsai@realtek.com>
> 
> Expose the device's Serial Number (SN) and UUID from EFUSE via two
> read-only sysfs attributes, `serial_number` and `uuid`, on the ieee80211
> phy device under the `rtw89_usb` attribute group.
> 
> This hardware identification information is essential for user-space
> applications to uniquely identify, track, and manage specific Wi-Fi
> adapters. For example, in automated factory provisioning or device
> management systems, user-space tools rely on the EFUSE serial number and
> UUID to bind configurations to specific physical adapters. Currently,
> standard wireless APIs do not expose this low-level hardware
> information, making these sysfs nodes the only viable solution for
> user space to extract this data.
> 
> The attributes are gated behind a new RTW89_QUIRK_HW_INFO_SYSFS quirk,
> enabled only for the VID 0x28de / PID 0x2432 device via the
> dev_id_quirks field in rtw89_driver_info.
> 
> Example usage from user-space:
>   $ cat /sys/class/ieee80211/phy0/rtw89_usb/serial_number
>   3642000123
>   $ cat /sys/class/ieee80211/phy0/rtw89_usb/uuid
>   aaec2b7c-0a55-4727-8de0-b30febccbbaa
> 
> Cc: Elliot Saba <sabae@valvesoftware.com>
> Cc: Charles Lohr <charlesl@valvesoftware.com>
> Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  .../ABI/testing/sysfs-class-ieee80211-rtw89   | 24 ++++++++
>  drivers/net/wireless/realtek/rtw89/core.h     |  6 ++
>  drivers/net/wireless/realtek/rtw89/rtw8852c.c | 10 ++++
>  drivers/net/wireless/realtek/rtw89/rtw8852c.h |  6 +-
>  .../net/wireless/realtek/rtw89/rtw8852cu.c    | 12 +++-
>  drivers/net/wireless/realtek/rtw89/usb.c      | 57 +++++++++++++++++++
>  6 files changed, 113 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-ieee80211-rtw89 b/Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
> new file mode 100644
> index 000000000000..7dfdce08a42f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
> @@ -0,0 +1,24 @@
> +What:		/sys/class/ieee80211/phyX/rtw89_usb/serial_number
> +Date:		May 2026
> +Contact:	Johnson Tsai <wenjie.tsai@realtek.com>, linux-wireless@vger.kernel.org
> +Description:	(Read) Serial number burned into EFUSE of the RTL8852CU-based
> +		USB Wi-Fi adapter.  Only present on devices that set the
> +		RTW89_QUIRK_HW_INFO_SYSFS quirk (currently VID 0x28de /
> +		PID 0x2432).
> +
> +		Format: %10phN (5 raw bytes printed as 10 lowercase hex
> +		digits, no separators).
> +
> +		Example: 3642000123
> +
> +What:		/sys/class/ieee80211/phyX/rtw89_usb/uuid
> +Date:		May 2026
> +Contact:	Johnson Tsai <wenjie.tsai@realtek.com>, linux-wireless@vger.kernel.org
> +Description:	(Read) UUID burned into EFUSE of the RTL8852CU-based USB Wi-Fi
> +		adapter.  Only present on devices that set the
> +		RTW89_QUIRK_HW_INFO_SYSFS quirk (currently VID 0x28de /
> +		PID 0x2432).
> +
> +		Format: %pUb (RFC 4122 UUID in lowercase with hyphens).
> +
> +		Example: aaec2b7c-0a55-4727-8de0-b30febccbbaa
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
> index e687216da5b6..09f17d958075 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -3615,6 +3615,9 @@ struct rtw89_sta_link {
>  	u32 data_tx_cnt_lmt:6;
>  };
>  
> +#define RTW89_EFUSE_SN_LEN 5
> +#define RTW89_EFUSE_UUID_LEN 16
> +
>  struct rtw89_efuse {
>  	bool valid;
>  	bool power_k_valid;
> @@ -3625,6 +3628,8 @@ struct rtw89_efuse {
>  	u8 adc_td;
>  	u8 bt_setting_2;
>  	u8 bt_setting_3;
> +	u8 sn[RTW89_EFUSE_SN_LEN];
> +	u8 uuid[RTW89_EFUSE_UUID_LEN];
>  };
>  
>  struct rtw89_phy_rate_pattern {
> @@ -5373,6 +5378,7 @@ enum rtw89_quirks {
>  	RTW89_QUIRK_PCI_BER,
>  	RTW89_QUIRK_THERMAL_PROT_120C,
>  	RTW89_QUIRK_THERMAL_PROT_110C,
> +	RTW89_QUIRK_HW_INFO_SYSFS,
>  
>  	NUM_OF_RTW89_QUIRKS,
>  };
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
> index 7bb1264bcaef..3861cce42b1b 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
> @@ -621,6 +621,15 @@ static void rtw8852c_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
>  	gain->offset_valid = valid;
>  }
>  
> +static void rtw8852c_efuse_copy_sn_uuid_usb(struct rtw89_dev *rtwdev,
> +					    const struct rtw8852c_efuse *map)
> +{
> +	struct rtw89_efuse *efuse = &rtwdev->efuse;
> +
> +	memcpy(efuse->sn, map->u.sn, sizeof(efuse->sn));
> +	memcpy(efuse->uuid, map->u.uuid, sizeof(efuse->uuid));
> +}
> +
>  static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
>  			       enum rtw89_efuse_block block)
>  {
> @@ -640,6 +649,7 @@ static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
>  		break;
>  	case RTW89_HCI_TYPE_USB:
>  		ether_addr_copy(efuse->addr, map->u.mac_addr);
> +		rtw8852c_efuse_copy_sn_uuid_usb(rtwdev, map);
>  		break;
>  	default:
>  		return -ENOTSUPP;
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
> index 8585921ac6c4..b1d7c354c18e 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
> @@ -13,7 +13,11 @@
>  struct rtw8852c_u_efuse {
>  	u8 rsvd[0x88];
>  	u8 mac_addr[ETH_ALEN];
> -};
> +	u8 rsvd1[8];
> +	u8 sn[RTW89_EFUSE_SN_LEN];
> +	u8 rsvd2[29];
> +	u8 uuid[RTW89_EFUSE_UUID_LEN];
> +} __packed;
>  
>  struct rtw8852c_e_efuse {
>  	u8 mac_addr[ETH_ALEN];
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> index 8f89f9a31455..81ee96b0a048 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
> @@ -39,6 +39,16 @@ static const struct rtw89_driver_info rtw89_8852cu_info = {
>  	},
>  };
>  
> +static const struct rtw89_driver_info rtw89_8852cu_valve_info = {
> +	.chip = &rtw8852c_chip_info,
> +	.variant = NULL,
> +	.quirks = NULL,
> +	.dev_id_quirks = BIT(RTW89_QUIRK_HW_INFO_SYSFS),
> +	.bus = {
> +		.usb = &rtw8852c_usb_info,
> +	},
> +};
> +
>  static const struct usb_device_id rtw_8852cu_id_table[] = {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03a6, 0xff, 0xff, 0xff),
>  	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
> @@ -53,7 +63,7 @@ static const struct usb_device_id rtw_8852cu_id_table[] = {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x991d, 0xff, 0xff, 0xff),
>  	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x28de, 0x2432, 0xff, 0xff, 0xff),
> -	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
> +	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_valve_info },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c7c, 0x8206, 0xff, 0xff, 0xff),
>  	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x35b2, 0x0502, 0xff, 0xff, 0xff),
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
> index 88d7ec200837..7e23d0a32025 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -1059,6 +1059,61 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev *rtwdev,
>  	usb_set_intfdata(intf, NULL);
>  }
>  
> +static ssize_t serial_number_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct wiphy *wiphy = container_of(dev, struct wiphy, dev);
> +	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
> +	struct rtw89_dev *rtwdev = hw->priv;
> +	struct rtw89_efuse *efuse = &rtwdev->efuse;
> +
> +	return sysfs_emit(buf, "%*phN\n",
> +			  (int)sizeof(efuse->sn), efuse->sn);
> +}
> +static DEVICE_ATTR_RO(serial_number);
> +
> +static ssize_t uuid_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct wiphy *wiphy = container_of(dev, struct wiphy, dev);
> +	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
> +	struct rtw89_dev *rtwdev = hw->priv;
> +	struct rtw89_efuse *efuse = &rtwdev->efuse;
> +
> +	return sysfs_emit(buf, "%pUb\n", efuse->uuid);
> +}
> +static DEVICE_ATTR_RO(uuid);
> +
> +static struct attribute *rtw89_usb_attrs[] = {
> +	&dev_attr_serial_number.attr,
> +	&dev_attr_uuid.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group rtw89_usb_group = {
> +	.name = "rtw89_usb",
> +	.attrs = rtw89_usb_attrs,
> +};
> +__ATTRIBUTE_GROUPS(rtw89_usb);
> +
> +static void rtw89_usb_sysfs_create(struct rtw89_dev *rtwdev)
> +{
> +	int ret;
> +
> +	if (!test_bit(RTW89_QUIRK_HW_INFO_SYSFS, rtwdev->quirks))
> +		return;
> +
> +	ret = sysfs_create_groups(&rtwdev->hw->wiphy->dev.kobj,
> +				  rtw89_usb_groups);

You just raced with userspace and lost, please use the is_visable
callback instead, and make this the default group attributes.

thanks,

greg k-h

