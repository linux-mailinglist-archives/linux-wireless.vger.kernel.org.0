Return-Path: <linux-wireless+bounces-31672-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKYeOZ5QimmmJQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31672-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 22:24:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1BA114C96
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 22:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3053630069A9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 21:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DBE30E828;
	Mon,  9 Feb 2026 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WlGvMKsv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5630EF83
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672282; cv=none; b=oMNHXYLnETugWCSNplDxy9KivUOo+lfavhLSwcUo36RAraujhWXPK7Rv/ubuI3na2QqJnKhONld99adkQlopcDAx8wB+FoxGvIeeA/2r+I7nnenxKVmFQnqBY9rr1Hn06Hyv5FzS61MoKeXpzBdI2oMxD1HDTUxEmznydrZDP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672282; c=relaxed/simple;
	bh=k4ChBkJuQ1KETGSfDZAqwPeewcI/hmL5pLC7pZ1MI3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDrGcXcYMfmkSto8kpozh8y7fHuC5vMPhbzrZ9axQo2I3G213iL4FJ9XmpaSqpyYsL2ZoBtJi+uHJiR9Y8pOAGyTsNUMK7qkTHX2moRf+9oOJMSLmyr0IA8EHMBzEm+obYIyko88BzotW6VEZ4eKfp9ClVgvzOLeljQh3V3SgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=WlGvMKsv; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id pX56vFkv1KXDJpYkDvFUcU; Mon, 09 Feb 2026 21:24:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pYkDvfBHSV6WMpYkDvwHC2; Mon, 09 Feb 2026 21:24:33 +0000
X-Authority-Analysis: v=2.4 cv=E//Npbdl c=1 sm=1 tr=0 ts=698a5091
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Mt98uAL8hC94oX8DrwaRjw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7T7KSl7uo7wA:10
 a=XcNdrpShkqf6tfskqv0A:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4pjN5qWZEuqPUTasqYbFWuAnYrVXZbafMF/aW3/Q7VI=; b=WlGvMKsv52En7y+6qoX1KQcrrr
	tzZEfSy7wR/lPqEJJfkzKM6KJ8kIiLggYNvY3hOO8gS2IhenC8jhI4Rb050wO5Eb6/0x2qYPGdd+V
	6ZCBp/if+U8MqlXumRZcvsDJ5XWjkF7krGAxmXECPM1UT8ZNkQcJrjKdNVTwqcfImI0ctoHmvDsh7
	frYAuBJ9CprTlZHduqAZakFu9h70Uhf00u1POUsq1CYoJEi7Kbl/CCkeem7HtQHDNmteyBpYlgHsE
	7VOgjPkvyT6BBd81+U4cGQ1cRQB9xKtEJ3ENlnRpF0tKCaGNYxB7FYBoVb61nJvExjOsC6RVF12mp
	k8xnTx/w==;
Received: from [177.238.18.130] (port=40928 helo=[192.168.0.100])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vpYkC-00000002cdj-2emv;
	Mon, 09 Feb 2026 15:24:32 -0600
Message-ID: <4bf43164-b130-4643-9f4f-761f49bd0dc9@embeddedor.com>
Date: Mon, 9 Feb 2026 15:23:59 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aYlkt2WP2oQ1TgeH@kspp> <202602091212.743C6B9B7C@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202602091212.743C6B9B7C@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.130
X-Source-L: No
X-Exim-ID: 1vpYkC-00000002cdj-2emv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.100]) [177.238.18.130]:40928
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfORZ/VXpZnmjjKazPRtwI++6iOXzY+flLmtO12gVnO7WsV6KYTfY8YcgIv0Lp7XIdgaWKkg+o9KktnS20q8fPoAQ+cxr1xrVPpYcY3DP0sJX1hi7W48M
 OoiRAPGtUufgnRUa3g1HjMnSx9BtzZz2Q69f2IIsaMiyab0/Vy54LrVzIQozRaOLh8iDR2YrKecbQrdlvJ4Ne02HPkwyfmwjC/GlV3SNqzjncJBkHGdNtnVL
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,sipsolutions.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-31672-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_X_SOURCE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[embeddedor.com];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,linux-wireless@vger.kernel.org];
	HAS_X_ANTIABUSE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F1BA114C96
X-Rspamd-Action: no action



On 2/10/26 05:46, Kees Cook wrote:
> On Mon, Feb 09, 2026 at 01:38:15PM +0900, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declarations (which in a couple of cases happen
>> to be in a union, so the entire unions are moved) to the end of the
>> corresponding structures. Notice that `struct il_tx_beacon_cmd`,
>> `struct il4965_tx_resp`, and `struct il3945_tx_beacon_cmd` are flexible
>> structures, this is structures that contain a flexible-array member.
> 
> I think explicit mention of il3945_frame and il_frame should be included
> in the commit log (probably after the above), as they are the ones that
> contain the mentioned il*_tx_beacon_cmd structs that have a trailing
> flex array.

Okay.

> 
>> The case for struct il4965_beacon_notif is different. Since this
>> structure is defined by hardware, we use the struct_group() helper
>> to create the new `struct il4965_tx_resp_hdr` type. We then use this newly
>> created type to replace the obhect type of  causing trouble in
>> struct il4965_beacon_notif, namely `stryct il4965_tx_resp`.
> 
> Above two lines have typos and maybe a missing name (between "of" and
> "causing")?

Aggh.. yes, I had fixed this before, but somehow I ended up using the
wrong changelog text. Thanks for the catch!

> 
>> In order to preserve the memory layout in struct il4965_beacon_notif,
>> add member `__le32 beacon_tx_status`, which was previously included
>> by `struct il4965_tx_resp` (as `__le32 status`), but it's not present
>> in the newly created type `struct il4965_tx_resp_hdr`.
> 
> It may help to explicitly mention how the union exists to provide the
> "status" member to anything using struct il4965_tx_resp, but there's no
> sane way to do the overlap across structs, so anything using
> il4965_beacon_notif needs have its own view of "status".

Okay.

> 
> It does feel like accessing il4965_tx_resp's agg_status should be using
> a different struct (like happens for other things that want bytes beyond
> "status"), but okay.
> 
> Anyway, it's another situation of a header with a trailing flex array
> that needs to overlap with differing deserializations of the trailing
> bytes. The complication here is the kind of "layering violation" of
> agg_status and status.
> 
>> Notice that after this changes, the size of struct il4965_beacon_notif
>> along with its member's offsets remain the same, hence the memory
>> layout doesn't change:
>>
>> Before changes:
>> struct il4965_beacon_notif {
>> 	struct il4965_tx_resp      beacon_notify_hdr;    /*     0    24 */
>> 	__le32                     low_tsf;              /*    24     4 */
>> 	__le32                     high_tsf;             /*    28     4 */
>> 	__le32                     ibss_mgr_status;      /*    32     4 */
>>
>> 	/* size: 36, cachelines: 1, members: 4 */
>> 	/* last cacheline: 36 bytes */
>> };
>>
>> After changes:
>> struct il4965_beacon_notif {
>> 	struct il4965_tx_resp_hdr  beacon_notify_hdr;    /*     0    20 */
>> 	__le32                     beacon_tx_status;     /*    20     4 */
>> 	__le32                     low_tsf;              /*    24     4 */
>> 	__le32                     high_tsf;             /*    28     4 */
>> 	__le32                     ibss_mgr_status;      /*    32     4 */
>>
>> 	/* size: 36, cachelines: 1, members: 5 */
>> 	/* last cacheline: 36 bytes */
>> };
>>
>> We also want to ensure that when new members are added to the flexible
>> structure `struct il4965_tx_resp` (if any), they are always included
>> within the newly created struct type. To enforce this, we use
>> `static_assert()` (which is intentionally placed right after the struct,
>> this is, no blank line in between). This ensures that the memory layout
>> of both the flexible structure and the new `struct il4965_tx_resp_hdr`
>> type remains consistent after any changes.
>>
>> Lastly, refactor the rest of the code, accordingly.
> 
> I think the changes look consistent with other similar logical changes
> that have been made for -Wfamnae.
> 
> Since enabling -fms-extensions I'm on the look-out for cases where
> we can use transparent struct members (i.e. define the header struct
> separately and then use it transparently) instead of using the struct
> group when we don't need to make the interior explicitly addressable
> (as we have in this case), as it makes the diff way smaller:

Ah yes, I can do this. The only thing is that I'd have to change every
place where members in struct il4965_tx_resp are used, e.g.

s/frame_count/hdr.frame_count

and so on...

Another thing to take into account (fortunately, not in this case) is
when the FAM needs to be annotated with __counted_by(). If we use a
separate struct for the header portion of the flexible structure, GCC
currently cannot _see_ the _counter_ if it's included in a non-anonymous
structure. However, this will be possible in the near future, correct?

> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
> index b61b8f377702..440dff2a4ad9 100644
> --- a/drivers/net/wireless/intel/iwlegacy/commands.h
> +++ b/drivers/net/wireless/intel/iwlegacy/commands.h
> @@ -1690,7 +1690,7 @@ struct agg_tx_status {
>   	__le16 sequence;
>   } __packed;
>   
> -struct il4965_tx_resp {
> +struct il4965_tx_resp_hdr {
>   	u8 frame_count;		/* 1 no aggregation, >1 aggregation */
>   	u8 bt_kill_count;	/* # blocked by bluetooth (unused for agg) */
>   	u8 failure_rts;		/* # failures due to unsuccessful RTS */
> @@ -1707,6 +1707,10 @@ struct il4965_tx_resp {
>   	__le16 reserved;
>   	__le32 pa_power1;	/* RF power amplifier measurement (not used) */
>   	__le32 pa_power2;
> +} __packed;
> +
> +struct il4965_tx_resp {
> +	struct il4965_tx_resp_hdr;
>   
>   	/*
>   	 * For non-agg:  frame status TX_STATUS_*
> @@ -2664,7 +2668,8 @@ struct il3945_beacon_notif {
>   } __packed;
>   
>   struct il4965_beacon_notif {
> -	struct il4965_tx_resp beacon_notify_hdr;
> +	struct il4965_tx_resp_hdr beacon_notify_hdr;
> +	__le32 status;
>   	__le32 low_tsf;
>   	__le32 high_tsf;
>   	__le32 ibss_mgr_status;
> 
> 
> What do folks think?

I'll wait for maintainers to chime in.

> 
>> With these changes fix the following warnings:
>>
>> 11 drivers/net/wireless/intel/iwlegacy/common.h:526:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> 11 drivers/net/wireless/intel/iwlegacy/commands.h:2667:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> 4 drivers/net/wireless/intel/iwlegacy/3945.h:131:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Yay for getting these gone! :)
> 

We're getting there! \o/

Thanks
-Gustavo


