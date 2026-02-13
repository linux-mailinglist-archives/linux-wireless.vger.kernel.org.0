Return-Path: <linux-wireless+bounces-31821-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEf0BGOfj2kuSAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31821-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 23:02:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80179139B38
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 23:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0713D303F7D7
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E473033EB;
	Fri, 13 Feb 2026 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Q0POnjli"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2005e-snip4-11.eps.apple.com [57.103.89.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A125C704
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771020106; cv=none; b=ZENU02PfRgxmAHLB3tSDk6254KsKhwyV3nrBr7YQOx92tATzSaez5TExmQhWgLHkC/22YfLgGL12qHwtoYv08WFlosvCH5L+tB+n/ynnufFKCG1GWjDP94blevboh2VwH1DgfuTI0mMspkUV1t4nEO6FBEl0mbkjftUPog2PQ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771020106; c=relaxed/simple;
	bh=J0F0OMucBMikMXBn7SbzD9mRVj3x1oAl9y7QFq83Zyk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rS9HB6hjSGfUkz6aMO1n66ZpdeGtiR9QHmrYpwcmuM22f1+AxwxticyhxiOlo1SL1ORNE5Iz7jc28MUcnS5SnzNkLjA27wzSjrIzoU99YT3sAb2lW7RDgUl1V/dws/Uh5nmS9x32NdBUYZ4W6hMOtkORi6lNzORJaySZQj9UU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Q0POnjli; arc=none smtp.client-ip=57.103.89.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-1 (Postfix) with ESMTPS id DEA1D180022D;
	Fri, 13 Feb 2026 22:01:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1771020100; x=1773612100; bh=0WIPUbqMg8AAvA743yHIjWkDhqAsH1LgsLi77gtcNAY=; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:x-icloud-hme; b=Q0POnjliZV7bTbVzNqsMnG1uj7I+732JvXrAJs76Mr/gNIvZXbbgo0h4F1vHKlFa6ltnJh9t2sGzok3uYyVIc3LiiEfjUOK20pJYMIh25O1i5ttcIRrSra+8mM9KWXaMmKpHzue2opqnhvAlRuUE69/3CvUWYjCxqAOdfE3vYohy0S+ulUZ5VfRozciwCYiFvcfwA53Ye87Xh1hK8tkxUdai5kRIesZXTKZzZE3PuesKAM7xC5JT4jIMjjYsV9K+wzDgogMQkZTb1qd7/QtqjwOlDJwQYEY2PP5Gnt/wrqRWcbl493CXYGaELHnW9JFS8ZOjAesSK0gVp8zwEAxgWw==
Received: from [172.31.0.10] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-1 (Postfix) with ESMTPSA id 2B3CE18000BF;
	Fri, 13 Feb 2026 22:01:38 +0000 (UTC)
Message-ID: <261dcee1-e5b9-4b9c-9052-f726fe5beb69@icloud.com>
Date: Fri, 13 Feb 2026 14:01:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: mac80211: question about 20/40 coex support
From: Alex Gavin <a_gavin@icloud.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aY7NLLnOCXS8L31z@FUE-ALEWI-WINX>
 <a3fd0a27-f09f-4950-919d-1b4ba2dcb16a@icloud.com>
 <aY7y84VZW465W_zr@FUE-ALEWI-WINX>
 <61276f01-5fdb-48d9-8c5a-cc3a765bb642@icloud.com>
Content-Language: en-US
In-Reply-To: <61276f01-5fdb-48d9-8c5a-cc3a765bb642@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XTDalC-kO2n1Wt9ll0yZc33ZfC9GlBuS
X-Proofpoint-GUID: XTDalC-kO2n1Wt9ll0yZc33ZfC9GlBuS
X-Authority-Info-Out: v=2.4 cv=A7Fh/qWG c=1 sm=1 tr=0 ts=698f9f43
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=h3XwevFeXowA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yaAG3qJ-AAAA:8
 a=SXzkmgPmAAAA:8 a=GJFuWvaYdyhl0ssDG44A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oLVlbjkABFOu4cUI0CGI:22 a=EWLf6cg6Bh5aS0AxDgDu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE2OSBTYWx0ZWRfXyYn4g/azB4sl
 z5bBV3woyLhG+BI4FCARNmGr2PGRhnAVnvKdAky0p+Fq7asOfPwiFW95jUomK21VS//cO5TAdd6
 i+qbHwv5Md8gt4XvFaO3dlS0lbmVoBnIHJY3jH5PokYqkdimGyTDMKDGmdHi+O7Ya7YvosNoZ0m
 fMeNYRmWt5/I7f+BESDTmNioWD/CEfKxFXuDRqvGZwlaOZBexoFlJJ35tjvjxfWrd7zUPFGcYZF
 UhVnsESG9OGv3tvMV6Xk3aWVku4mZP2X7UM/7sG4GI7XdnIWzUFlRJ0DCz5qzio5xUK6tu+z+Pz
 3LPe/JTAykTkYWmSBE7sGqhz/SXE9N95Gw3Io08Bhwg2H0tK51KRKUWOy9rBr0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_05,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130169
X-JNJ: AAAAAAABgFqyEE/feHR9tr3PgD2+rUj135Z/DC0Cxwzdwqu8DdpvDDNspw8Nu46RpuR0HHyCDdLMaqkQ6m41j4zaQtMxUequsy8BTT+rblrwbIqGh2hLluckuhR3K2WzE18kHVP19g2y3LSrxTa72vPG+X0M0mMpKo8WTrTZ/JGyLtMA/IEZa7+wG21WhvHuHcCSMIcSgaE59Y80/DlDwoztq10QMspIANtzSxuXW51KOkdWdyw7B8CokUwTAtxYA+rQgRC3uIFOYp6kjvaQW/wrMLdAfUhx5+ORppULG0uQwKO644vBjTgAmCl4PO1SncH28IG+SgCS3aoL0g1RLAzkRPx/IPXpi2Q4P8gWM2NgYL9GoClmPAVlOv7LpGWb3xwbylTFKlIkuEgah9W24pXXHjB8u+PkfbrictR8zOkedMy7JSC626cGwjxS43SQcmeS0VHB+TwCdGZpIuOhjwI0Vrh/l1R2YXhhyZHUP4N+ES9biAZ4K2WT6M1QPzfOLjyZzyzbc8KXxNBIF3JAr7HIRMfRW9jq07zqqvCONaWRmwkHs6eYE5UBAN2Ng3TgZ5YKS01AE2/M8ad1LoCT9LcAo4uH0QOsOOt1Ikx0ExedTbIlGqZ5RxGq3Ople0lrXSSTatvBTX/EWrT2JGYYvbuyKv80RgYMxx6s1IRjqZg6jmJ0iKaX9XBA6HYxxPgKmfDvGKYXBanNIL+SaULTvQ7S8z2W9ittRODDgdQtJbGviA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31821-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[icloud.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[icloud.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a_gavin@icloud.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[w1.fi:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeberg.org:url,icloud.com:mid,icloud.com:dkim]
X-Rspamd-Queue-Id: 80179139B38
X-Rspamd-Action: no action

On 2/13/26 13:44, Alex Gavin wrote:
> On 2/13/26 01:46, Alexander Wilhelm wrote:
>> On Fri, Feb 13, 2026 at 12:14:16AM -0800, Alex Gavin wrote:
>>> On 2/12/26 23:05, Alexander Wilhelm wrote:
>>>>
>>>> Hello wireless devs,
>>>>
>>>> I am analyzing a wireless management frame taken from the beacon of an
>>>> access point, and in this frame the `20/40 Coexistence Management Support`
>>>> bit is set to 0, indicating that the feature is not supported. See frame
>>>> below:
>>>>
>>>>     Frame 2: 217 bytes on wire (1736 bits), 217 bytes captured (1736 bits)
>>>>     Radiotap Header v0, Length 26
>>>>     802.11 radio information
>>>>     IEEE 802.11 Beacon frame, Flags: ........
>>>>     IEEE 802.11 Wireless Management
>>>>         Fixed parameters (12 bytes)
>>>>         Tagged parameters (155 bytes)
>>>>             Tag: SSID parameter set: "SSID"
>>>>             Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
>>>>             Tag: DS Parameter set: Current Channel: 6
>>>>             Tag: Traffic Indication Map (TIM): DTIM 0 of 2 bitmap
>>>>             Tag: Country Information: Country Code DE, Environment All
>>>>             Tag: ERP Information
>>>>             Tag: QBSS Load Element 802.11e CCA Version
>>>>             Tag: Supported Operating Classes
>>>>             Tag: HT Capabilities (802.11n D1.10)
>>>>             Tag: HT Information (802.11n D1.10)
>>>>             Tag: Extended Capabilities (10 octets)
>>>>                 Tag Number: Extended Capabilities (127)
>>>>                 Tag length: 10
>>>>                 Extended Capabilities: 0x04 (octet 1)
>>>>                     .... ...0 = 20/40 BSS Coexistence Management Support: Not supported
>>>>                     .... ..0. = General Link (GLK): 0x0
>>>>                     .... .1.. = Extended Channel Switching: Supported
>>>>                     .... 0... = GLK-GCR: 0x0
>>>>                     ...0 .... = PSMP Capability: Not supported
>>>>                     ..0. .... = Reserved: 0x0
>>>>                     .0.. .... = S-PSMP Support: Not supported
>>>>                     0... .... = Event: Not supported
>>>>                 Extended Capabilities: 0x00 (octet 2)
>>>>                 Extended Capabilities: 0x00 (octet 3)
>>>>                 Extended Capabilities: 0x02 (octet 4)
>>>>                 Extended Capabilities: 0x00 (octet 5)
>>>>                 Extended Capabilities: 0x00 (octet 6)
>>>>                 Extended Capabilities: 0x01 (octet 7)
>>>>                 Extended Capabilities: 0x0040 (octets 8 & 9)
>>>>                 Extended Capabilities: 0x40 (octet 10)
>>>>             Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element
>>>>
>>>> I reviewed several driver implementations, and none of them seem to
>>>> advertise this capability. I also could not find any definition for this
>>>> bit in `include/linux/ieee80211.h`, unlike many other capability bits that
>>>> are defined (e.g. `WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING` or
>>>> `WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT`). From what I can see, none of the
>>>> `mac80211`‑based drivers appear to support this feature, is that correct?
>>>>
>>>> Additionally, I want to confirm whether my understanding of the feature is
>>>> accurate: the 20/40 Coexistence mechanism implements the “good neighbor”
>>>> policy, meaning that an AP using a 40 MHz channel in the 2.4 GHz band must
>>>> fall back to 20 MHz when it detects an overlapping BSS (OBSS). Is that
>>>> right?
>>>>
>>>> Any clarification would be greatly appreciated.
>>>>
>>>>
>>>> Best regards
>>>> Alexander Wilhelm
>>>>
>>>
>>> From my understanding, this is implemented in userspace (i.e. hostapd), at least in upstream code.
>>
>> I've alredy seen the code in `hostapd` that implements a fallback to 20
>> MHz. But that implementation is based only on scan results, not on 20/40
>> coexistence feautre. Here the snippet from `ieee80211n_check_scan`
>> function:
>>
>>     [...]
>>     if (iface->current_mode->mode == HOSTAPD_MODE_IEEE80211A)
>>             oper40 = ieee80211n_check_40mhz_5g(iface, scan_res);
>>     else
>>             oper40 = ieee80211n_check_40mhz_2g4(iface, scan_res);
>>     wpa_scan_results_free(scan_res);
>>
>>     iface->secondary_ch = iface->conf->secondary_channel;
>>     if (!oper40) {
>>             wpa_printf(MSG_INFO, "20/40 MHz operation not permitted on "
>>                        "channel pri=%d sec=%d based on overlapping BSSes",
>>                        iface->conf->channel,
>>                        iface->conf->channel +
>>                        iface->conf->secondary_channel * 4);
>>             iface->conf->secondary_channel = 0;
>>             if (iface->drv_flags & WPA_DRIVER_FLAGS_HT_2040_COEX) {
>>                     /*
>>                      * TODO: Could consider scheduling another scan to check
>>                      * if channel width can be changed if no coex reports
>>                      * are received from associating stations.
>>                      */
>>             }
>>     }
>>     [...]
> 
> There are ways the BSS can switch from 40 MHz to 20 MHz operation beyond just scan results.
> 
> For example, a newly-associated, 40 MHz intolerant station could cause hostapd to reconfigure to 20
> MHz operation, assuming the WPA_DRIVER_FLAGS_HT_2040_COEX is set by radio driver capabilities.
> 
> Directly handling association:
> 
> handle_assoc()
> -> update_ht_state()
> -> update_sta_ht()
> -> ht40_intolerant_add()
> -> ieee802_11_set_beacons()
> -> ieee802_11_set_beacon()
> -> __ieee802_11_set_beacon()
> -> ieee802_11_build_ap_params()
> -> hostapd_build_ap_extra_ies()
> -> hostapd_eid_ext_capab()
> -> hostapd_ext_capab_byte()
> 
> 
> Or from driver callback:
> 
> hostapd_notif_assoc()
> -> ht40_intolerant_add()
> -> ieee802_11_set_beacons()
> ...
> -> hostapd_ext_capab_byte()
> 
> 
> Additionally, receipt of a 20/40 MHz Coex Management Action frame in 'hostapd_2040_coex_action()'
> may trigger the AP to reconfigure to 20 MHz using a similar code path.
> 
> For testing, wpa_supplicant supports configuring 40 MHz intolerant stations. See below from its
> config file reference [1]:
> 
> # ht40_intolerant: Whether 40 MHz intolerant should be indicated.
> # 0 = 40 MHz tolerant (default)
> # 1 = 40 MHz intolerant
> 
> I've uploaded some example hostapd and wpa_supplicant configs here [2], if you'd like something to
> reference or play around with. Associating the intolerant station config should trigger hostapd to
> switch from 40 MHz to 20 MHz with this configuration, assuming radio driver support as mentioned above.
> 
> [1] https://git.w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf
> [2] https://codeberg.org/a-gavin/hostap-confs/src/branch/main/open/20-40MHz-bss-coexistence

Since you mentioned packet capture analysis, to observe a 40 MHz BSS switch to 20 MHz operation, pay
close attention to the HT Operation IE in the Beacon frames.

Assuming you're using Wireshark, you should see the 'HT Operation Information Subset (1 of 3)'
section switch from showing 'Supported channel width: Channel of any width supported' to '20 MHz
channel width only'. I'm sure other programs are similar.

Using the 40 MHz intolerant association example, you should see this switch immediately after
station association.


40 MHz operation:

Tag: HT Operation
    Tag Number: HT Operation (61)
    Tag length: 22
    Primary Channel: 1
    HT Operation Information Subset (1 of 3): 0x05
        .... ..01 = Secondary channel offset: Secondary channel is above the primary channel (0x1)
        .... .1.. = Supported channel width: Channel of any width supported
        .... 0... = Reduced Interframe Spacing (RIFS): Prohibited
        0000 .... = Reserved: 0x0
    HT Operation Information Subset (2 of 3): 0x0000
    HT Operation Information Subset (3 of 3): 0x0000
    Rx Supported Modulation and Coding Scheme Set: Basic MCS Set


20 MHz operation:

Tag: HT Operation
    Tag Number: HT Operation (61)
    Tag length: 22
    Primary Channel: 1
    HT Operation Information Subset (1 of 3): 0x00
        .... ..00 = Secondary channel offset: No secondary channel (0x0)
        .... .0.. = Supported channel width: 20 MHz channel width only
        .... 0... = Reduced Interframe Spacing (RIFS): Prohibited
        0000 .... = Reserved: 0x0
    HT Operation Information Subset (2 of 3): 0x0000
    HT Operation Information Subset (3 of 3): 0x0000
    Basic HT-MCS Set: Reserved: 00000000000000000000000000000000


Hope this helps!

>>> In hostapd, the '20/40 BSS Coexistence Management Support' bit you reference is set in the
>>> 'hostapd_ext_capab_byte()' function in 'src/ap/ieee802_11_shared.c' when 'obss_interval' is set in
>>> the AP config file.
>>>
>>> For more information on the 'obss_interval' config item see the following from the hostapd config
>>> reference here [1]:
>>>
>>> # If set non-zero, require stations to perform scans of overlapping
>>> # channels to test for stations which would be affected by 40 MHz traffic.
>>> # This parameter sets the interval in seconds between these scans. Setting this
>>> # to non-zero allows 2.4 GHz band AP to move dynamically to a 40 MHz channel if
>>> # no co-existence issues with neighboring devices are found.
>>> #obss_interval=0
>>
>> Great, I found the the configuration in my `hostapd` version and the code
>> that implements the handling of this kind of management frames. I'll give
>> the configuration option a try.
>>
>>> The following sections from the 802.11 standard may be helpful to understand this topic in more
>>> depth, although I'm sure there's information online that may be easier to digest:
>>>
>>> - 9.4.2.58 20/40 BSS Coexistence element
>>> - 9.4.2.54.2 HT Capability Information field
>>> - 11.15.12 Switching between 40 MHz and 20 MHz
>>>
>>> From 11.15.12:
>>>
>>> TE-B: On any of the channels of the channel set defined in Clause 18, reception of a 20/40 BSS
>>> Coexistence Management, Beacon, Probe Request, or Probe Response frame that contains a value of 1 in
>>> a Forty MHz Intolerant field and that has the Address 1 field equal to the receiving STA’s address
>>> or to a group address, with no further addressing qualifications.
>>
>> Thank you for the support, Alex. The information helps me a lot.
>>
>>
>> Best regards
>> Alexander Wilhelm
> 
> 


