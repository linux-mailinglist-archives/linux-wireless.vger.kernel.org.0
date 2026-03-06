Return-Path: <linux-wireless+bounces-32591-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMV4NKWSqml0TQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32591-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:39:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5862721D32F
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 09:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0238302E852
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8905C372B3A;
	Fri,  6 Mar 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jfw/I+Fa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405353793B1;
	Fri,  6 Mar 2026 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786338; cv=none; b=P6SZMCHsJpN6DIXDU6q5IP9en+hVQAQ88eHOtmhAQsBwp8zngx2Wyrnu/a6eIZu9vF3uRYhh/unDDIjsTXjwhXLcRzXNJngyQ17dWm37Gn+UFHbx+hnXMyG6pVBhx5UcJ3x8AjJWmLp7JJsi9lyrNGdVw+E5t6j8oU9NFifb6cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786338; c=relaxed/simple;
	bh=7NFLjIKW3fJXKMGDcC7K37k5SC2w9YE31AyGa3DgpVU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EWU83xUR7wrD5Dggne/lQAS3D3zcyhX0jKLf6UZv0Lxr5N8qMQ9H2wjn1pHuDA4g4gdqww+YRVbIIW9u/2XOCy4Pfew3oFuzfGlB2aafdaCnpyholfefMnp4YPGuJYIYBwfucY3MeyaYyfUBZphVcVxbw2A0sa966TpGT1YsUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jfw/I+Fa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YjLuKClxB0Etf2WFSuuiqn2UEtDwEO6r+GBdofBN+QM=;
	t=1772786337; x=1773995937; b=jfw/I+Fa+5v0sav7hA4dy1A7oU0pFro0s/oqB3sI3E21Hqn
	4LzHLQzsxt+KriqdG8K1mlihTo+tbc1Uz+9XvnPq7ntvGvCDB8b5F4OsiiAb+g3WOi3oHUvBXY1q/
	ox4OdkyADBs2ptuHFcBEi2E9FE1TfQg4HT86IKgnHEFY9cZi+fVD2c7JA1hsUSllCM05sufWCgCns
	TFvaKxFSDSosFjc6sJywUo5Z38T2EKg4oMVDBA9F0S01NYDkMkEf4DuQ/q5CuAjlPJOj5nXDXZ0uG
	jua0tL4PD+xtD7tVhDkVNOSWBm1cAnEmErHySB3xGhMhyJ8fS34XmTo79Ro0bDwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vyQhy-00000009zBl-2idx;
	Fri, 06 Mar 2026 09:38:54 +0100
Message-ID: <2e7f8bc64e13743deb4bf90eac2a50920af9f862.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 02/35] wifi: mm81x: add command.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, Dan Callaghan
	 <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 06 Mar 2026 09:38:53 +0100
In-Reply-To: <20260227041108.66508-3-lachlan.hodges@morsemicro.com> (sfid-20260227_051156_408438_F971C92F)
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
	 <20260227041108.66508-3-lachlan.hodges@morsemicro.com>
	 (sfid-20260227_051156_408438_F971C92F)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: 5862721D32F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32591-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

Hi,

Hm. So I _was_ going to say this just _looked_ bad, but now I think it's
actually wrong:

On Fri, 2026-02-27 at 15:10 +1100, Lachlan Hodges wrote:
> +int mm81x_cmd_sta_state(struct mm81x *mm, struct mm81x_vif *mm_vif, u16 =
aid,
> +			struct ieee80211_sta *sta,
> +			enum ieee80211_sta_state state)
> +{
> +	struct host_cmd_req_set_sta_state req;
> +	struct host_cmd_resp_set_sta_state resp;
> +
> +	memset(&req, 0, sizeof(req));

This is fine of course.

> +	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_SET_STA_STATE, mm_vif->id,
> +		       sizeof(req));
> +
> +	memcpy(req.sta_addr, sta->addr, sizeof(req.sta_addr));
> +	req.aid =3D cpu_to_le16(aid);
> +	req.state =3D cpu_to_le16(state);
> +	req.uapsd_queues =3D sta->uapsd_queues;

(you write other fields here otherwise it'd be useless)


But then there are cases like this:

> +int mm81x_cmd_add_if(struct mm81x *mm, u16 *vif_id, const u8 *addr,
> +		     enum nl80211_iftype type)
> +{
> +	int ret;
> +	struct host_cmd_req_add_interface req;
> +	struct host_cmd_resp_add_interface resp;
> +
> +	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_ADD_INTERFACE, 0, sizeof(req))=
;
> +
> +	switch (type) {
> +	case NL80211_IFTYPE_STATION:
> +		req.interface_type =3D cpu_to_le32(HOST_CMD_INTERFACE_TYPE_STA);
> +		break;
> +	case NL80211_IFTYPE_AP:
> +		req.interface_type =3D cpu_to_le32(HOST_CMD_INTERFACE_TYPE_AP);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	memcpy(req.addr.octet, addr, sizeof(req.addr.octet));
> +
> +	ret =3D mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
> +			   (struct host_cmd_req *)&req, sizeof(resp), 0);


Where you're sending uninitialised data to the firmware, regardless of
what the actual command does, mm81x_cmd_init() doesn't initialise the
'pad' field in the header, and there might be per-command fields too?


It'd also be far more obvious that it's not sending uninitialised data
if it was simply each command built as a C99 initialiser:

#define INIT_HDR(_var, _cmd, _vif_id)                           \
        {                                                       \
                .message_id =3D cpu_to_le16(_cmd),                \
                .vif_id =3D cpu_to_le16(_vif_id),                 \
                .len =3D sizeof(_var) - sizeof(_var).hdr,         \
        }

...

int mm81x_cmd_sta_state(struct mm81x *mm, struct mm81x_vif *mm_vif, u16 aid=
,
                        struct ieee80211_sta *sta,
                        enum ieee80211_sta_state state)
{
        struct host_cmd_req_set_sta_state req =3D {
                .hdr =3D INIT_HDR(req, HOST_CMD_ID_SET_STA_STATE, mm_vif->i=
d),
                .aid =3D cpu_to_le16(aid),
                .state =3D cpu_to_le16(state),
                .uapsd_queues =3D sta->uapsd_queues,
        };
        struct host_cmd_resp_set_sta_state resp;

        memcpy(req.sta_addr, sta->addr, sizeof(req.sta_addr));

        return mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
                            (struct host_cmd_req *)&req, sizeof(resp), 0);
}


etc.

That assumes .hdr is always the header, but that didn't seem
unreasonable. It also doesn't work for a few cases that dynamically
allocate (filter), but that could just use kzalloc() instead.


It also seems (and that's really nitpicking now) that the response
argument to mm81x_cmd_tx() is actually optional, so a few (more) places
like this one could use NULL there (e.g. also key removal, beacon timer,
frag threshold)

johannes

