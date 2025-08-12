Return-Path: <linux-wireless+bounces-26319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B4B22A0B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 16:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4658E3B8722
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4EF2D12F7;
	Tue, 12 Aug 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fh-aachen.de header.i=@fh-aachen.de header.b="vUYfG4n8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-out-1a.itc.rwth-aachen.de (mail-out-1a.itc.rwth-aachen.de [134.130.5.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC32D0C93
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.130.5.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007409; cv=none; b=uJZagdS8vVyYplVpHi8JAP+afmaGb9Ys6wD2Y0lCquwaaYDdZqngxdnvGunoZBa7/PqM3tjhSPGxs6Zm+SA2/x2UDz0wMV4GnZqEzG/J6g4vsfmms9F/6XULSSsOR2GkvgLKYHFO5NbII0TxJ9wOqGKjYD00Wek3FnQlFUbU0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007409; c=relaxed/simple;
	bh=2Ijl7C2UEZ4zKhoAruSmUlWxUuOroafNweNdZSuFY/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RC8QQYiLJ+kzckhWaRc8W+0RwrkQhqG6mQPeFQZ8m+nOwA5ZRz0ijM4xStp1/ziAXNyfZDWrlp+ic8P+TAAorQOwS8q7zHTbboXUs4K4RstIWW8LVFwId8bqYkUlWNaIDoEFNaYsiaHE+2ytfYUZ/rg7PH2BNnYmvmrFbmdWiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fh-aachen.de; spf=pass smtp.mailfrom=fh-aachen.de; dkim=pass (2048-bit key) header.d=fh-aachen.de header.i=@fh-aachen.de header.b=vUYfG4n8; arc=none smtp.client-ip=134.130.5.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fh-aachen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fh-aachen.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fh-aachen.de; i=@fh-aachen.de; q=dns/txt; s=fhac;
  t=1755007405; x=1786543405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=2Ijl7C2UEZ4zKhoAruSmUlWxUuOroafNweNdZSuFY/o=;
  b=vUYfG4n8w/sTc4VLv9nMdbShzkRrXsFlEqIMjpxbD6hmOy1EljcHzZ77
   /NOGcEaTaUd83mCm7qjTeijBB70JJIoJTOHT7IbBfbbmEwg8EQg/mC9fu
   M5IBSdNICHjH1lARSSSTqS2ZfzrHO3iZJ0UUDew+jvY+gc5rH/noaewOC
   ZjFlDeD6wBciXPC9tYzO7jq5AbV4PLlYzMvyIgx70/6jDcQx7NtDjwrMz
   gVSw3fQEFZVIv2KcICXN7KC0wv0iDcyrReBrSqJhv0oOGfKmwkoAqzlxB
   2Yj+DtjCDdHt2twS+5bWVXb2rms+s9UZaBeltR7gahDoksjxh9M2TUhd0
   Q==;
X-CSE-ConnectionGUID: QkKZ+MseRcWb6BlXxZw0Rw==
X-CSE-MsgGUID: kWMISKz/QHe7n7j1uhehcQ==
X-IPAS-Result: =?us-ascii?q?A2A3AADmSJto/74agoZaHQEBAQEJARIBBQUBSYE2CAELA?=
 =?us-ascii?q?YM/LoE3HYQ3iByJVQOLZJI2gX8PAQEBAQEBAQEBBAQBPRQEAQGFBwKMIyc0C?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEGAQEBAQEBBgWBIYYJRg2GWwEFI?=
 =?us-ascii?q?wRSEAIBCA0LKgICAh4RJQIEAQ0FDoJ1gjkDIBIUr2N/MxoCZd09DYJLCgaBS?=
 =?us-ascii?q?QGBV4MrgzAeAYFbEoMMcxuEXEKCDYEVgTuBbz6CH0IEGIFdg0SCaQSCIkRSj?=
 =?us-ascii?q?DGEM4F1A4dAUoFwLAFVExcLBwWBIBAzAyAKNBUcAhQNIg8aBS0dcwwoEmuEG?=
 =?us-ascii?q?4QnK0+CInWBAXhBGT+DUx4Gaw8GgRUZHi0CAgIFAkM+gWAXBh4GIBICAgICA?=
 =?us-ascii?q?jpAAwttPTcGDhsGkXMSIUeBWYJzNhZ4LCCBJT0xCpMAHZN7nRWBU3EDB4I1g?=
 =?us-ascii?q?WeGXYMzgg6PPYZJl2AdA5JrLphYIo1mhAmSEIR1AgQCBAUCGIFoghVxFDuCZ?=
 =?us-ascii?q?1IXAo48FohxrQp4PAIHCwEBAwmSSgGBHAEB?=
IronPort-Data: A9a23:uZ9nr6lSX5u/ZoE8XWx+1o/o5gyRJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOXmHUPfaPYmXzc4p1aYW39ExXsMOBxtFqHQdoriA8E1tH+JHPbTi7wuYcHAvPdJGZHBI/h
 yk6QoOdRCzhZiaE/n9BCpC48z8kk/jOHuOtYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWcrWo4ow/jb8k437K2r4GpwUmEWPJingnePzxH5M7pCfcldH1OgKqFIE+izQ
 fr0zb3R1gvx4xc3B9q5pa3we0sMT6S6FVDmZq1+AvXKbrBq/0Te445jXBYuQR4/Zwahw7id/
 O5wWamYEm/FCIWRwrhHA0kAe81JFfYuFLfveRBTuCEIpqHMWyOEL/5GVCnaMWCEkwp6KTkmy
 BAWFNwCRimApND15am2cOJTjJoJKPn7DpxHgG41mFk1Dd5+KXzCa6vK6M8dw211jIZHEbDQZ
 48QYDFvYRKGbxAn1lU/Ucli2r7z3j+lLXsB+Qr9SakfugA/yCR02aX3PcD9dNzPTMxenkue4
 G7Ll4j8KkhBaYHGkWvZohpAgMfMogbaY6EAU4SY+6Fs31/K22weCBYvAA7TTf6RzxTWt8hkA
 04W/Sootq803E+mVN/wW1u/unHslh4BWcsOTrcS5wSEy66S6AGcbkAATzhceJk5tdU7QTExz
 XeXkN7zQz9iqruYTTSa7Lj8hTquOXFNLkcGZDQYVk0E5df5qY0+hx6JScxseJNZlfWsQm22m
 mvS6nJgwexC1abnypmGwLwOuBr0zrChc+L/zl+/sr6Nhu+hWLOYWg==
IronPort-HdrOrdr: A9a23:kvZVOqnHPVH6ZEeu5EygWwwP02HpDfIC3DAbv31ZSRFFG/Fwz/
 re+8jy1XfP5wr5K0tQ/+xoWZPwO080mqQFgrX5UY3OYOCighrNEGgA1/qe/9SDIVydygc178
 4JGMJD4Z/LfD1HZK3BjjVQZuxB/DDxysGVbInlo0uFBjsaEp2Ipz0JcjpzPHcGPzV7OQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AXJj1HmuQxr396/A/6L638vYn6IsccV7vj1LLLnW?=
 =?us-ascii?q?zNmw3YrmlWW2PoJl7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ABjlGuA7GuTa1f8BpEFSSp812xoxr3IGPM2Mf1qw?=
 =?us-ascii?q?mtpaCai4pJjeQjD+OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,284,1747692000"; 
   d="p7s'346?scan'346,208,346";a="135510948"
Received: from unknown (HELO fhex-w2-b.ad.fh-aachen.de) ([134.130.26.190])
  by mail-in-1a.itc.rwth-aachen.de with ESMTP; 12 Aug 2025 16:02:14 +0200
Received: from fhex-w2-a.ad.fh-aachen.de (134.130.26.189) by
 fhex-w2-b.ad.fh-aachen.de (134.130.26.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 16:02:13 +0200
Received: from fhex-w2-a.ad.fh-aachen.de ([fe80::d79a:cbcf:214:4a68]) by
 fhex-w2-a.ad.fh-aachen.de ([fe80::d79a:cbcf:214:4a68%2]) with mapi id
 15.02.1748.026; Tue, 12 Aug 2025 16:02:13 +0200
From: "Maurer, Florian" <maurer@fh-aachen.de>
To: "jjohnson@kernel.org" <jjohnson@kernel.org>, "hujy652@gmail.com"
	<hujy652@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Subject: Re: [RFC PATCH] wifi: ath10k: support flush_sta method
Thread-Topic: [RFC PATCH] wifi: ath10k: support flush_sta method
Thread-Index: AQHcC43BTpo2NJF1LUeBSr+y24h5QLRe6sMA
Date: Tue, 12 Aug 2025 14:02:13 +0000
Message-ID: <f18395e36493e9f3b91e20a2209045029ba02b64.camel@fh-aachen.de>
References: <20250806070005.1429-1-hujy652@gmail.com>
In-Reply-To: <20250806070005.1429-1-hujy652@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/signed; micalg=sha-384;
	protocol="application/pkcs7-signature"; boundary="=-sMXpaab5G0yXIS/prQRi"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-sMXpaab5G0yXIS/prQRi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

we tested this patch at Freifunk Aachen using Gluon/OpenWrt.

We had the issue that the Extreme Networks WS-AP3825i did have a high
load in a busy environment, making the node unresponsive.
This issue is resolved with this patch, improving the wifi stability
noticeably, similar to
https://patchwork.kernel.org/project/linux-wireless/list/?series=3D911851

Restarting Wifi (using wifi) still logs

kern.warn kernel: [98526.968626] ath10k_warn: 617 callbacks suppressed
kern.warn kernel: [98526.968651] ath10k_pci a000:03:00.0: could not get
mac80211 beacon
kern.warn kernel: [98527.071045] ath10k_pci a000:03:00.0: could not get
mac80211 beacon
kern.warn kernel: [98532.104123] ath10k_pci a000:03:00.0: failed to
flush transmit queue (skip 0 ar-state 1): 0

Just like it was with the other patch.
We did also not see any "failed to flush sta" message in dmesg.

Thanks,
Florian Maurer

Tested-by: Florian Maurer <maurer@fh-aachen.de>

On Wed, 2025-08-06 at 15:00 +0800, Zhi-Jun You wrote:
> When a STA is marked as no longer authorized, if the driver doesn't
> implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
> flush hardware queues to avoid sending unencrypted frames.
>=20
> This has became a problem for ath10k because ieee80211_flush_queues()
> will stop all traffic and call ath10k_flush, which waits until the
> whole HW queue is empty. In a busy environment this will trigger a
> timeout warning and stalls other STAs.
>=20
> Fix this by implementing flush_sta method using WMI command to flush
> frames of a specific STA.
> Flushed frames will be marked as discard in tx complete indication.
>=20
> ops->flush_sta will be set to NULL if htt.disable_tx_comp is set to
> true.
>=20
> Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00157
>=20
> Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/mac.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless=
/ath/ath10k/mac.c
> index 24dd794e31ea..6959f20334a7 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -8135,6 +8135,20 @@ static void ath10k_flush(struct ieee80211_hw *hw, =
struct ieee80211_vif *vif,
>  	mutex_unlock(&ar->conf_mutex);
>  }
> =20
> +static void ath10k_mac_op_flush_sta(struct ieee80211_hw *hw, struct ieee=
80211_vif *vif,
> +			     struct ieee80211_sta *sta)
> +{
> +	struct ath10k_vif *arvif =3D (void *)vif->drv_priv;
> +	struct ath10k *ar =3D hw->priv;
> +	u32 bitmap =3D 0xFFFFFFFF;
> +	int ret =3D 0;
> +
> +	ret =3D ath10k_wmi_peer_flush(ar, arvif->vdev_id, sta->addr, bitmap);
> +	if (ret)
> +		ath10k_warn(ar, "failed to flush sta (sta %pM)\n",
> +			    sta->addr);
> +}
> +
>  /* TODO: Implement this function properly
>   * For now it is needed to reply to Probe Requests in IBSS mode.
>   * Probably we need this information from FW.
> @@ -9487,6 +9501,7 @@ static const struct ieee80211_ops ath10k_ops =3D {
>  	.set_rts_threshold		=3D ath10k_set_rts_threshold,
>  	.set_frag_threshold		=3D ath10k_mac_op_set_frag_threshold,
>  	.flush				=3D ath10k_flush,
> +	.flush_sta			=3D ath10k_mac_op_flush_sta,
>  	.tx_last_beacon			=3D ath10k_tx_last_beacon,
>  	.set_antenna			=3D ath10k_set_antenna,
>  	.get_antenna			=3D ath10k_get_antenna,
> @@ -10294,6 +10309,9 @@ int ath10k_mac_register(struct ath10k *ar)
>  	if (!ar->hw_params.hw_ops->set_coverage_class)
>  		ar->ops->set_coverage_class =3D NULL;
> =20
> +	if (ar->htt.disable_tx_comp)
> +		ar->ops->flush_sta =3D NULL;
> +
>  	ret =3D ath_regd_init(&ar->ath_common.regulatory, ar->hw->wiphy,
>  			    ath10k_reg_notifier);
>  	if (ret) {

--=-sMXpaab5G0yXIS/prQRi
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgIFADCABgkqhkiG9w0BBwEAAKCCFXgw
ggbmMIIEzqADAgECAhAxAnDUNb6bJJr4VtDh4oVJMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0yMDAyMTgwMDAwMDBaFw0zMzA1MDEyMzU5NTlaMEYxCzAJBgNVBAYT
Ak5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBD
QSA0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAs0riIl4nW+kEWxQENTIgFK600jFA
xs1QwB6hRMqvnkphfy2Q3mKbM2otpELKlgE8/3AQPYBo7p7yeORuPMnAuA+oMGRb2wbeSaLcZbpw
XgfCvnKxmq97/kQkOFX706F9O7/h0yehHhDjUdyMyT0zMs4AMBDRrAFn/b2vR3j0BSYgoQs16oSq
adM3p+d0vvH/YrRMtOhkvGpLuzL8m+LTAQWvQJ92NwCyKiHspoP4mLPJvVpEpDMnpDbRUQdftSpZ
zVKTNORvPrGPRLnJ0EEVCHR82LL6oz915WkrgeCY9ImuulBn4uVsd9ZpubCgM/EXvVBlViKqusCh
SsZEn7juIsGIiDyaIhhLsd3amm8BS3bgK6AxdSMROND6hiHT182Lmf8C+gRHxQG9McvG35uUvRu8
v7bPZiJRaT7ZC2f50P4lTlnbLvWpXv5yv7hheO8bMXltiyLweLB+VNvg+GnfL6TW3Aq1yF1yrZAZ
zR4MbpjTWdEdSLKvz8+0wCwscQ81nbDOwDt9vyZ+0eJXbRkWZiqScnwAg5/B1NUD4TrYlrI4n6zF
p2pyYUOiuzP+as/AZnz63GvjFK69WODR2W/TK4D7VikEMhg18vhuRf4hxnWZOy0vhfDR/g3aJbds
Gac+diahjEwzyB+UKJOCyzvecG8bZ/u/U8PsEMZg07iIPi8CAwEAAaOCAYswggGHMB8GA1UdIwQY
MBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBRpAKHHIVj44MUbILAK3adRvxPZ5DAO
BgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYI
KwYBBQUHAwQwOAYDVR0gBDEwLzAtBgRVHSAAMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VU0VS
VHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYB
BQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNy
dDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOC
AgEACgVOew2PHxM5AP1v7GLGw+3tF6rjAcx43D9Hl110Q+BABABglkrPkES/VyMZsfuds8fcDGvG
E3o5UfjSno4sij0xdKut8zMazv8/4VMKPCA3EUS0tDUoL01ugDdqwlyXuYizeXyH2ICAQfXMtS+r
az7mf741CZvO50OxMUMxqljeRfVPDJQJNHOYi2pxuxgjKDYx4hdZ9G2o+oLlHhu5+anMDkE8g0tf
fjRKn8I1D1BmrDdWR/IdbBOj6870abYvqys1qYlPotv5N5dm+XxQ8vlrvY7+kfQaAYeO3rP1DM8B
GdpEqyFVa+I0rpJPhaZkeWW7cImDQFerHW9bKzBrCC815a3WrEhNpxh72ZJZNs1HYJ+29NTB6uu4
NJjaMxpk+g2puNSm4b9uVjBbPO9V6sFSG+IBqE9ckX/1XjzJtY8Grqoo4SiRb6zcHhp3mxj3oqWi
8SKNohAOKnUc7RIP6ss1hqIFyv0xXZor4N9tnzD0Fo0JDIURjDPEgo5WTdti/MdGTmKFQNqxyZuT
9uSI2Xvhz8p+4pCYkiZqpahZlHqMFxdw9XRZQgrP+cgtOkWEaiNkRBbvtvLdp7MCL2OsQhQEdEbU
vDM9slzZXdI7NjJokVBq3O4pls3VD2z3L/bHVBe0rBERjyM2C/HSIh84rfmAqBgklzIOqXhd+4Rz
adUwggdDMIIFK6ADAgECAhEA5Q83/HnuDY7AOJSV3MypqjANBgkqhkiG9w0BAQwFADBGMQswCQYD
VQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29u
YWwgQ0EgNDAeFw0yNDA5MTIwMDAwMDBaFw0yNjA5MTIyMzU5NTlaMIG+MQswCQYDVQQGEwJERTEc
MBoGA1UECBMTTm9yZHJoZWluLVdlc3RmYWxlbjEeMBwGA1UEChMVRmFjaGhvY2hzY2h1bGUgQWFj
aGVuMREwDwYDVQRhEwhHT1ZERStOVzEiMCAGCSqGSIb3DQEJARYTbWF1cmVyQGZoLWFhY2hlbi5k
ZTEPMA0GA1UEBBMGTWF1cmVyMRAwDgYDVQQqEwdGbG9yaWFuMRcwFQYDVQQDEw5GbG9yaWFuIE1h
dXJlcjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMFVDFkoHUu7AOshXKj70qxer6i3
pk+LynP+jX8adH5pKnfizwqI1mzvPyiCfNU7XC8ePRErd+j3eguupndM8uMJrt5VGSYjcnv5dl9v
42RfhYK0lYgo5u52YVp3dlftWu2jaA4Cn026yUs8COJEOglYuV5uvAX3577t0MT+x4NDNbLVluU9
wsXSx5ihSq824IFR7oJLpkU/LxBSU7arAJZBEiSFRK07ghgU/HoUtKtYtg/RAFw5rU4z7WijOHpJ
MhRZGa0Lmw6TBl4D2hsmaet41k4NVMofEQlcskm28eA7p3NRihcks2684oKPcriOfY0TMz5HEU0q
IQ9Hmc0yBHuMOziU0HSPsvdeOojoqTNz6u5d1oPbYvPUtxFHhRJXFKQp8Lsz3L/oyAqULtPhlZ7Z
D8T3YkvECWKuHHGFkzH5Dq9c3Mq75U1PW1egHl3LB7ZcobanbOManDY3c8xaA54ePHQf8etTRWFr
aCeNMMJZTykOLug2eoM+w+Q06kISK+Y7MYjfI8rZHoqMNPzQanOp+b2ST7pZjzA6X68jDje1cgxl
PtcjIXnWIUTwaslGZzn3jRkMOFy+7lQW/29FZHbkCEwOtFDbFI4ZICQ+SzmYegBqEcRagXi7PArQ
OgxWTYtg82+N8phJgomCyp+Yah6iAwL/9qVQPf7pyH5deWXdAgMBAAGjggGxMIIBrTAfBgNVHSME
GDAWgBRpAKHHIVj44MUbILAK3adRvxPZ5DAdBgNVHQ4EFgQUZLrpDWivnhVBL1qLNqnng/buKHAw
DgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUF
BwMCMFAGA1UdIARJMEcwOgYMKwYBBAGyMQECAQoEMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vc2Vj
dGlnby5jb20vU01JTUVDUFMwCQYHZ4EMAQUDAjBCBgNVHR8EOzA5MDegNaAzhjFodHRwOi8vR0VB
TlQuY3JsLnNlY3RpZ28uY29tL0dFQU5UUGVyc29uYWxDQTQuY3JsMHgGCCsGAQUFBwEBBGwwajA9
BggrBgEFBQcwAoYxaHR0cDovL0dFQU5ULmNydC5zZWN0aWdvLmNvbS9HRUFOVFBlcnNvbmFsQ0E0
LmNydDApBggrBgEFBQcwAYYdaHR0cDovL0dFQU5ULm9jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcw
FYETbWF1cmVyQGZoLWFhY2hlbi5kZTANBgkqhkiG9w0BAQwFAAOCAgEAnnDgg2ycAk7TwQ2v8rie
Z3NpREN5q9l8WNr8qsrAijWqsqVOIJeEWUJPT2S/EfRrdNCb+jW4MOD0PGYzIEK2FNbUBXIDxbf2
pliT1X405Mmq7MnFw70fwcEzzuNo3ZevD3RrWjRy8HCRzDND3odP9Im4z/+rdSdyAzNiCevxOL5m
lZ2LSTGgl2zlgn0l8TWXX1fNVJDGl53foOfofPSHuy/Fg6LVgrDWWd2LS/cTXT4hiH3X+EBY0hRs
+TVitKKt7O2xLv4cnip2T89h3K//iSye771cXuH24WQ4QExn7NM9CHSXGfhRbCtx8lZD/bpymvln
yIA02cMCwOMyg4x+O6n+HE2tZp4ttsusjF2m6LMVqCYO2yza4w7zxMbxnIfkFeAFNn/9ScFtM48l
5bhc9WoGshX0gquK9AK8aNNHYnLsni2lMnCed1rdM8ViN9kla2nlgateekdGxjtUBvnWIGmB2ZAP
lTWpCIq3DmGMdQFubfRi/dXk00yh4tiwuMLLb+zrM3IkgOv0r53CFedbe3OOuSyKA0MJrLZwApTf
FoqP/nBsXwXwnDycuLCQcbDgXz/OuuQvv/cbuMhIgLeq9xTpzws2FMSHaltDMrAonVJEH++8pEcX
voMlgWR/HQHid4j4FnR2kFrTXhHiPElCqMze9du/mDfOWqQSaXWpJkIwggdDMIIFK6ADAgECAhEA
5Q83/HnuDY7AOJSV3MypqjANBgkqhkiG9w0BAQwFADBGMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQ
R0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29uYWwgQ0EgNDAeFw0yNDA5MTIw
MDAwMDBaFw0yNjA5MTIyMzU5NTlaMIG+MQswCQYDVQQGEwJERTEcMBoGA1UECBMTTm9yZHJoZWlu
LVdlc3RmYWxlbjEeMBwGA1UEChMVRmFjaGhvY2hzY2h1bGUgQWFjaGVuMREwDwYDVQRhEwhHT1ZE
RStOVzEiMCAGCSqGSIb3DQEJARYTbWF1cmVyQGZoLWFhY2hlbi5kZTEPMA0GA1UEBBMGTWF1cmVy
MRAwDgYDVQQqEwdGbG9yaWFuMRcwFQYDVQQDEw5GbG9yaWFuIE1hdXJlcjCCAiIwDQYJKoZIhvcN
AQEBBQADggIPADCCAgoCggIBAMFVDFkoHUu7AOshXKj70qxer6i3pk+LynP+jX8adH5pKnfizwqI
1mzvPyiCfNU7XC8ePRErd+j3eguupndM8uMJrt5VGSYjcnv5dl9v42RfhYK0lYgo5u52YVp3dlft
Wu2jaA4Cn026yUs8COJEOglYuV5uvAX3577t0MT+x4NDNbLVluU9wsXSx5ihSq824IFR7oJLpkU/
LxBSU7arAJZBEiSFRK07ghgU/HoUtKtYtg/RAFw5rU4z7WijOHpJMhRZGa0Lmw6TBl4D2hsmaet4
1k4NVMofEQlcskm28eA7p3NRihcks2684oKPcriOfY0TMz5HEU0qIQ9Hmc0yBHuMOziU0HSPsvde
OojoqTNz6u5d1oPbYvPUtxFHhRJXFKQp8Lsz3L/oyAqULtPhlZ7ZD8T3YkvECWKuHHGFkzH5Dq9c
3Mq75U1PW1egHl3LB7ZcobanbOManDY3c8xaA54ePHQf8etTRWFraCeNMMJZTykOLug2eoM+w+Q0
6kISK+Y7MYjfI8rZHoqMNPzQanOp+b2ST7pZjzA6X68jDje1cgxlPtcjIXnWIUTwaslGZzn3jRkM
OFy+7lQW/29FZHbkCEwOtFDbFI4ZICQ+SzmYegBqEcRagXi7PArQOgxWTYtg82+N8phJgomCyp+Y
ah6iAwL/9qVQPf7pyH5deWXdAgMBAAGjggGxMIIBrTAfBgNVHSMEGDAWgBRpAKHHIVj44MUbILAK
3adRvxPZ5DAdBgNVHQ4EFgQUZLrpDWivnhVBL1qLNqnng/buKHAwDgYDVR0PAQH/BAQDAgWgMAwG
A1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMFAGA1UdIARJMEcwOgYM
KwYBBAGyMQECAQoEMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vc2VjdGlnby5jb20vU01JTUVDUFMw
CQYHZ4EMAQUDAjBCBgNVHR8EOzA5MDegNaAzhjFodHRwOi8vR0VBTlQuY3JsLnNlY3RpZ28uY29t
L0dFQU5UUGVyc29uYWxDQTQuY3JsMHgGCCsGAQUFBwEBBGwwajA9BggrBgEFBQcwAoYxaHR0cDov
L0dFQU5ULmNydC5zZWN0aWdvLmNvbS9HRUFOVFBlcnNvbmFsQ0E0LmNydDApBggrBgEFBQcwAYYd
aHR0cDovL0dFQU5ULm9jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETbWF1cmVyQGZoLWFhY2hl
bi5kZTANBgkqhkiG9w0BAQwFAAOCAgEAnnDgg2ycAk7TwQ2v8rieZ3NpREN5q9l8WNr8qsrAijWq
sqVOIJeEWUJPT2S/EfRrdNCb+jW4MOD0PGYzIEK2FNbUBXIDxbf2pliT1X405Mmq7MnFw70fwcEz
zuNo3ZevD3RrWjRy8HCRzDND3odP9Im4z/+rdSdyAzNiCevxOL5mlZ2LSTGgl2zlgn0l8TWXX1fN
VJDGl53foOfofPSHuy/Fg6LVgrDWWd2LS/cTXT4hiH3X+EBY0hRs+TVitKKt7O2xLv4cnip2T89h
3K//iSye771cXuH24WQ4QExn7NM9CHSXGfhRbCtx8lZD/bpymvlnyIA02cMCwOMyg4x+O6n+HE2t
Zp4ttsusjF2m6LMVqCYO2yza4w7zxMbxnIfkFeAFNn/9ScFtM48l5bhc9WoGshX0gquK9AK8aNNH
YnLsni2lMnCed1rdM8ViN9kla2nlgateekdGxjtUBvnWIGmB2ZAPlTWpCIq3DmGMdQFubfRi/dXk
00yh4tiwuMLLb+zrM3IkgOv0r53CFedbe3OOuSyKA0MJrLZwApTfFoqP/nBsXwXwnDycuLCQcbDg
Xz/OuuQvv/cbuMhIgLeq9xTpzws2FMSHaltDMrAonVJEH++8pEcXvoMlgWR/HQHid4j4FnR2kFrT
XhHiPElCqMze9du/mDfOWqQSaXWpJkIxggPdMIID2QIBATBbMEYxCzAJBgNVBAYTAk5MMRkwFwYD
VQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBDQSA0AhEA5Q83
/HnuDY7AOJSV3MypqjANBglghkgBZQMEAgIFAKCCAVMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjUwODEyMTQwMjEyWjA/BgkqhkiG9w0BCQQxMgQwUQdm+qb5cxV9
/MGzhp4Kb3aJKf2c9DIVnBIFIibHL9TgBISvf81BEZpgN5z1AOOIMGoGCSsGAQQBgjcQBDFdMFsw
RjELMAkGA1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcxHDAaBgNVBAMTE0dFQU5U
IFBlcnNvbmFsIENBIDQCEQDlDzf8ee4NjsA4lJXczKmqMGwGCyqGSIb3DQEJEAILMV2gWzBGMQsw
CQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVy
c29uYWwgQ0EgNAIRAOUPN/x57g2OwDiUldzMqaowDQYJKoZIhvcNAQEBBQAEggIAG+MWmSBUgTkx
0YHbITW8H1NGcHtjRc+OTYyl7MwnTtfd0isZAfmsoi2ErZnc4LdbFEDR2659pa+eKsdp3nMkG9lX
ylp1PW5umGdsHZ2Q38rrGXxQ60dnryAPvMUL9rs6CN8di8HvW7Fb7meiU6ldlPZNQP8mQ8N1E9qS
GqVonU/XWFxfMlJ0WBosFTVagodG5RPeZaaV9FolBIxP8Dc9aVxZMEjaMirEtKciq0dn/XjDNTOr
VZBDXYGatAJtd+RAWWGGyp2XapBocdvBz+eRCOj82oMJ8GxqXftHHeez5S/GhRMQZSRzsDVY8tF9
d9KqYtHtF0XFVMMjfUOOWT2famVt9pNiQDoLSrq9aDsP2+eNG0CB2SKciCn7IMup13LkxI/ealD3
pnh+PNM621JoL+tssc/dyUqsgwKyb4IznEewTrBi6PGTXL4qjTxgMqtE+jmZe21D1ysnacQOzbDl
oUuLjdanblpaEdLaxOwatMXBLMrIeqrkrMRPCl35wFCSBQ12+l+6AMNTkbB0Rmod2GSc1zMzw5Vg
qH6MdOpiceNopImMYW45UMzX8lpf6ZXZz0jLRg0L9VxqEwD4vaa+jrEzKzbCunfJfyBxAA5rmPsP
V2ZcBfEcxihMQukP3loaXAI0khc+s3OSvq84JZLkANLB1+UhEUYHPwlNwgBgSnsAAAAAAAA=


--=-sMXpaab5G0yXIS/prQRi--

