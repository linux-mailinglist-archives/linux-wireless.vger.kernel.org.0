Return-Path: <linux-wireless+bounces-34006-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABc+NxqNxWlG/QQAu9opvQ
	(envelope-from <linux-wireless+bounces-34006-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 20:46:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E633B1BA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 20:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEC1C30A8FD6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 19:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357CF3A5E87;
	Thu, 26 Mar 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="XTH6vNZf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05E34BA5A
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554014; cv=none; b=MKlfLaNEflIAb9ga9Rhdg56KdukrR1311seNly/j0lDxNu1ydTmYcF9XVt9L4nCDV+yYZ/3z8guxGMcH8aRYGY/RYtPSUGWZH96Eokmg5xuKLAmXueSsDwrmpLrlfyUthH/VIfdBohSPMX4Cb9tHd9RzhEoc4WviURvVNhHoC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554014; c=relaxed/simple;
	bh=vrl0CXld5pnl3+j2iO7woriOvcxFLATcV9RLuYGwkcU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=f+whBkSgEa4OY6DNv2Am+dp9k6dabxxrySEVpMwBtVEnCRJqlaDiSKHIzIPii+6H6QyuByz0WXlb8NVyE4aqi9mvd/xfx5soCuSwXAZjIU2D4r31C4c7eFYfEU7r93V4TqTHJFvPu2R55fc1OwkdENt0uO6Fq6QzqQK+u0GsU2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=XTH6vNZf; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1774553998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sSZdOlH6LcaXmEulL+Z3vD5W8JNjS8vj1IOyQwqalY=;
	b=XTH6vNZfTs+Rhn/5LbLqBySMN0ZX5pl6xsbTh9654tQcRAh1k+4nFg2w4G1u1qCntQiaZ8
	A/R2MUis4bsWUAwdlxAgvsKMoCQTVTKo5FYZ+UF5W86+DpeBTmUVbgxC4++ZpZuZrgdUd4
	CJEUl378fYQ+f+HtmI79PftGLkYVsggFhKDl/3JVteu3ZiYS8a22o8T7OP9KUtpDC4JYac
	9CXVos/p6+ikPQVwciRBc6BdRnFiAKhP5CmwYb+nAvENQrNDTM6rf7qlh3ECM895NMgvQF
	+ztY6H8YDr09klaAyYgCcmhSwrhKLlLhwgvTQs0BGGViqdjhMKM87IDTt2Ed8Q==
Date: Thu, 26 Mar 2026 19:39:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Paul Sajna" <sajattack@postmarketos.org>
Message-ID: <425dcdb501ed6ebb0e652c58ef2c56c78754884b@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH v4 2/3] ath10k: Add device-tree quirk to skip host cap
 QMI requests
To: david@ixit.cz, "Johannes Berg" <johannes@sipsolutions.net>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Jeff Johnson" <jjohnson@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>
Cc: "Amit Pundir" <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org,
 devicetree@vger.kernel.org, ath10k@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 phone-devel@vger.kernel.org, "David Heidelberg" <david@ixit.cz>
In-Reply-To: <20260325-skip-host-cam-qmi-req-v4-2-bc08538487aa@ixit.cz>
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
 <20260325-skip-host-cam-qmi-req-v4-2-bc08538487aa@ixit.cz>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[postmarketos.org,quarantine];
	R_DKIM_ALLOW(-0.20)[postmarketos.org:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34006-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sajattack@postmarketos.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[postmarketos.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:email]
X-Rspamd-Queue-Id: 831E633B1BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

March 25, 2026 at 5:57 PM, "David Heidelberg via B4 Relay" <devnull+david=
.ixit.cz@kernel.org mailto:devnull+david.ixit.cz@kernel.org?to=3D%22David=
%20Heidelberg%20via%20B4%20Relay%22%20%3Cdevnull%2Bdavid.ixit.cz%40kernel=
.org%3E > wrote:


>=20
>=20From: Amit Pundir <amit.pundir@linaro.org>
>=20
>=20Some firmware versions do not support the host capability QMI request=
.
> Since this request occurs before firmware-N.bin and board-M.bin are
> loaded, the quirk cannot be expressed in the firmware itself.
>=20
>=20The root cause is unclear, but there appears to be a generation of
> firmware that lacks host capability support.
>=20
>=20Without this quirk, ath10k_qmi_host_cap_send_sync() returns
> QMI_ERR_MALFORMED_MSG_V01 before loading the firmware. This error is no=
t
> fatal - Wi-Fi services still come up successfully if the request is sim=
ply
> skipped.
>=20
>=20Add a device-tree quirk to skip the host capability QMI request on de=
vices
> whose firmware does not support it.
>=20
>=20For example, firmware build
> "QC_IMAGE_VERSION_STRING=3DWLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1"
> on Xiaomi Poco F1 phone requires this quirk.
>=20
>=20Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/net/wireless/ath/ath10k/qmi.c | 13 ++++++++++---
>  drivers/net/wireless/ath/ath10k/snoc.c | 3 +++
>  drivers/net/wireless/ath/ath10k/snoc.h | 1 +
>  3 files changed, 14 insertions(+), 3 deletions(-)
>=20
>=20diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wire=
less/ath/ath10k/qmi.c
> index eebd78e7ff6bc..e7f90fd9e9b83 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -808,6 +808,7 @@ ath10k_qmi_ind_register_send_sync_msg(struct ath10k=
_qmi *qmi)
>  static void ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
>  {
>  struct ath10k *ar =3D qmi->ar;
> + struct ath10k_snoc *ar_snoc =3D ath10k_snoc_priv(ar);
>  int ret;
>=20=20
>=20 ret =3D ath10k_qmi_ind_register_send_sync_msg(qmi);
> @@ -819,9 +820,15 @@ static void ath10k_qmi_event_server_arrive(struct =
ath10k_qmi *qmi)
>  return;
>  }
>=20=20
>=20- ret =3D ath10k_qmi_host_cap_send_sync(qmi);
> - if (ret)
> - return;
> + /*
> + * Skip the host capability request for the firmware versions which
> + * do not support this feature.
> + */
> + if (!test_bit(ATH10K_SNOC_FLAG_SKIP_HOST_CAP_QUIRK, &ar_snoc->flags))=
 {
> + ret =3D ath10k_qmi_host_cap_send_sync(qmi);
> + if (ret)
> + return;
> + }
>=20=20
>=20 ret =3D ath10k_qmi_msa_mem_info_send_sync_msg(qmi);
>  if (ret)
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wirel=
ess/ath/ath10k/snoc.c
> index f72f236fb9eb3..3106502275781 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1362,6 +1362,9 @@ static void ath10k_snoc_quirks_init(struct ath10k=
 *ar)
>=20=20
>=20 if (of_property_read_bool(dev->of_node, "qcom,snoc-host-cap-8bit-qui=
rk"))
>  set_bit(ATH10K_SNOC_FLAG_8BIT_HOST_CAP_QUIRK, &ar_snoc->flags);
> +
> + if (of_property_read_bool(dev->of_node, "qcom,snoc-host-cap-skip-quir=
k"))
> + set_bit(ATH10K_SNOC_FLAG_SKIP_HOST_CAP_QUIRK, &ar_snoc->flags);
>  }
>=20=20
>=20 int ath10k_snoc_fw_indication(struct ath10k *ar, u64 type)
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wirel=
ess/ath/ath10k/snoc.h
> index 1ecae34687c21..46574fd8f84ee 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.h
> +++ b/drivers/net/wireless/ath/ath10k/snoc.h
> @@ -51,6 +51,7 @@ enum ath10k_snoc_flags {
>  ATH10K_SNOC_FLAG_MODEM_STOPPED,
>  ATH10K_SNOC_FLAG_RECOVERY,
>  ATH10K_SNOC_FLAG_8BIT_HOST_CAP_QUIRK,
> + ATH10K_SNOC_FLAG_SKIP_HOST_CAP_QUIRK,
>  };
>=20=20
>=20 struct clk_bulk_data;
>=20
>=20--=20
>=202.53.0
>

Tested-by: Paul Sajna <sajattack@postmarketos.org>

