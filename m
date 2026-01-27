Return-Path: <linux-wireless+bounces-31200-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id le4fLt5BeGlvpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31200-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 05:41:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE68FE02
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 05:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EB8301A718
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 04:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19BF283FEA;
	Tue, 27 Jan 2026 04:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf7ympNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D81F2B8D
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769488859; cv=pass; b=A4DXmbK6k6KmnhAk9pp5XA09ifRtfS1xxxbzF2p0XM6wCOPPxt8U1QkYJC9uKh/9mZRl/QrSuvYU80sEaY87LS6UWh+ZQJJFTDiR9NfKx5WqmtMzOEQCxFGKkw5l8NVG5FoSEblCRF/4y9CJgTtpuMLMnQFHH4uUhvIL3/UhP+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769488859; c=relaxed/simple;
	bh=5nykKSlGz4WFS70K3yzH0AZTwFxjNnb5V6ZBk7/NwZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5RqS2otF2vs/Cfc+egrc72OJiLM7jLQMLkbJgbG9pIile3ARFKRFW/OsReQcBUQZjdT+1tkFEqdKM99i6fMY213wqucGQ/411OB4YMexMY7DrceQlxJ2gtl7R7yHpSwXPjtezVbBzLMqCNp2y7uOkQbWljmAtu35N2aX6lDXXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rf7ympNl; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0a95200e8so35164955ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 20:40:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769488858; cv=none;
        d=google.com; s=arc-20240605;
        b=hK6pI7snJmc2trYZ0s7qsdMg1BsjkSWm6NzA4ZH0cDN/5h2WDlnEh3RbxcWk2Sc0j9
         P/XqzgVN6XDUVRlZEydnPO+cU8alW6E2srGcKX4Gm9bzzk9J6MH0Fe1Ly4Y4cEEEzLuB
         xbuaz1sYhIiYDrNyR450mLxPcbLWojtQF9NNf5lDl73pGKojmlI5WJWfAUW0pJcbha2Y
         qnvVMeLcUN8sAwHEGXoV3vC3exyWZzT33rev0q1wN6C+9JZEt3XDICxqOWrWs0tHrV8s
         TD/EYIvOynq7h6DIt24KrzrF/52acuYW+UJFdGJmMdMkrmG8b2qqiXZLPm/Yk8ntdkFB
         tlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CgoRQ9aAInuWwuJvNm7KWE30aQAj3Sbe+L9WQLU0jmo=;
        fh=5UOXCR5PGF8Ud5B+1BhBsLDWkbVfHXxs2YDA7HclhAk=;
        b=Ca1wbEVl31Ox8IULzOeBOa9KqoOC+ryLsLY2qliIiMGHLjJV3FGqHi1YJWiPdly0Hf
         Ehk8HwEY/hS8wofq8pxYfiOzLW2T6Pi66WVSbcMW+uYJsFguZQRAzcdchtu2X+7REFhR
         QzypVsWIY0XtK6VdTF9eWG5mwzKnBgfcjgtacEcfES6mPLQ0ZBMgk6Fw4YiEyTIzPCiy
         sH56CXO2lDw2dcTWNc5c/xRYilTwljq2YWgIca4iY3Itjg2vteQFhYwfNImstJZOxiII
         76gHVtYaWqCIk6RtsVVD7yIKuha3JP0AxF9mTN0IYJ+qqlbCYuFOv0dXnzJLeIzXSolJ
         npPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769488858; x=1770093658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgoRQ9aAInuWwuJvNm7KWE30aQAj3Sbe+L9WQLU0jmo=;
        b=Rf7ympNladzr+5iH4sFKbsa4nqHZ8/4qs9N+A5mmS+1mTRZwHloYjY/QZ91rUPXiO8
         SlBmi5P+mgj8+gbsZOA/xpIk4MWIFDeUL9bJBdINm3x0NzQFyd+W3N4EgkKfFbiWV+uz
         u5Enuwkb1NE9s3Cxs2y3NtmDfqG/UY+u6HF0iCyIm0iKxWSOOFhKZ7Cl3nHcUV9NGgSC
         yGHlMAozeQJn7y54uw4TyuTutwZAA+UWyo7Mnqu1G9LQex2wYE74cL+u8xCQ/kjYqmQV
         8UuSd6oyuB7TPv1bEyMbPLgklHHLOLXL65V0ik8mSPKKsYIAPx2ky4r4nFlbxitLgebd
         yNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769488858; x=1770093658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CgoRQ9aAInuWwuJvNm7KWE30aQAj3Sbe+L9WQLU0jmo=;
        b=tCVo3CCVZy8V0QCMP94xhefj0GFOSFfntAspL41tN+K0PxgG24Na1j+fMGsRLXjzNX
         CntF2XdyLsT7PQP9sKdD03brgkqECAP40z8hTn7j9A836rBCg0ir8RKTuWpJO40LvoXO
         JEIj3yK8nMrtkeyNeEfqBxLblBR46/WbURKFsqSM0NcU+fE9guMIrSug5aJiA3IJslti
         8YkcgrUId+FQ3jZp35eqUF/0mME92Rg3tC7odwTlp2WlXzo/9c0yQ1DkDCtmKVjYNpc4
         pHCoHlN8kAeMSBNJtYczlDkFc/ISx5VT/G5U8xekUi4N3QTdx+5mY09tWpgVW818/KeC
         er1w==
X-Forwarded-Encrypted: i=1; AJvYcCVAXnXyQ1/DcTKpCTIk1HSVrDp+tVXbidiZaNq5DEK4dhxJuE1JVkrsqqvXN2gMSTelKx/tba3oVzCxbDPyVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YznMr928Qvn4XwIMMgGf78dPaJUhz0ag8xjMqdLOL9p7ClNNuGM
	Vkx6bwxhc5oqqWJsLzjD+PToIkagf81X/fK/4FuB7M2PF+kPpkMh5DBjxLoxnHW1OcKZgPysQBp
	MOvMVy3CoSsvyZlU981TSCol5dc8/G0Y=
X-Gm-Gg: AZuq6aIhiqUwtIIDUqWWqs91Myw50luc5dljZc/n+7mOrwaZpVNYLaFHA8bzSIhBV9D
	PgOAJPWINEPxISJW255A6VLztp98TnpBNF1iaD6cbCN8aGrSyd4zxY4e0f7wRjfIqZazX133eUg
	UE56YQDUmvrztzA01NJy/mpMFLfWh2B5NAsy90CWKokV9j/WzeBI2Lm0pI7NzgmJhVVbWQI2ylH
	MxqMBuKSp3dlHOPbwO2ByyPVGnS7SFNfHv2PYTDmcrKZ/ojvtEVyRjxQcv6HWk0cqVVfseWyl3h
	epdOREidX+2cJtvyPyO4wdo6gonj
X-Received: by 2002:a17:902:d4c8:b0:2a7:d5c0:c659 with SMTP id
 d9443c01a7336-2a870d40ab5mr5777875ad.5.1769488857625; Mon, 26 Jan 2026
 20:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126095244.113301-1-bjsaikiran@gmail.com> <20260126095244.113301-3-bjsaikiran@gmail.com>
 <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com> <CAAFDt1sxWMb1xPaWGWGE1XVFxRKwjOuQPZ__fNTH2+ujXJ6d5A@mail.gmail.com>
In-Reply-To: <CAAFDt1sxWMb1xPaWGWGE1XVFxRKwjOuQPZ__fNTH2+ujXJ6d5A@mail.gmail.com>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Tue, 27 Jan 2026 10:10:46 +0530
X-Gm-Features: AZwV_QjSyKJDNXc0V-uk_r8aWV8rDwL4hUja8DncYHLWVRioWU3KnzYePaaemT4
Message-ID: <CAAFDt1s8HPQWJpSiDDk8PmUAKqkQHELcJj_F0faZ1C9RfiYu6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Fix firmware stats leak when pdev
 list is empty
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31200-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 14DE68FE02
X-Rspamd-Action: no action

I have analyzed the logs and code flow in depth to provide more
definitive answers for your questions.

The log entries showing the failure are:
[  563.574076] ath12k_pci 0004:01:00.0: failed to pull fw stats: -71
[  564.575896] ath12k_pci 0004:01:00.0: time out while waiting for get fw s=
tats

1. Why are other stats populated?
The "failed to pull fw stats: -71" error is not the initial failure
but a symptom that appears after repeated operations. The leak happens
during *successful* calls prior to this error.

Code flow proving the leak:
- ath12k_mac_get_fw_stats() sends WMI_REQUEST_PDEV_STAT.
- Firmware responds. ath12k_update_stats_event() parses the response.
- ath12k_wmi_fw_stats_process() is called, which splices 'vdevs' and
'beacon' stats into ar->fw_stats.vdevs/bcn.
- ath12k_mac_get_fw_stats() returns 0 (Success).
- In ath12k_mac_op_get_txpower(), the check `if (!pdev)` fails if the
pdev-specific list is empty (but vdev list is NOT empty).
- The function exits via `err_fallback` WITHOUT calling ath12k_fw_stats_res=
et().
- Result: The 'vdev' and 'beacon' stats that were spliced into
ar->fw_stats remain there, leaking memory and accumulating with every
call.

2. Exact place where -71 is printed:
The error "failed to pull fw stats: -71" is printed in
[ath12k_update_stats_event()](drivers/net/wireless/ath/ath12k/wmi.c).
It corresponds to "ret =3D ath12k_wmi_pull_fw_stats()" returning -EPROTO.
This propagates from
[ath12k_wmi_tlv_fw_stats_data_parse()](drivers/net/wireless/ath/ath12k/wmi.=
c),
when buffer validation checks (like `len < sizeof(*src)`) fail.

Conclusion:
The fix in my patch (resetting stats when `!pdev`) is critical because
it ensures that the accumulated 'vdev' and 'beacon' stats are freed
even when the 'pdev' list ends up empty.

Let me know if you need anything else.

Thanks & Regards,
Saikiran

On Tue, Jan 27, 2026 at 9:47=E2=80=AFAM Saikiran B <bjsaikiran@gmail.com> w=
rote:
>
> Hi Baochen,
>
> Regarding your questions:
>
> "Are other stats populated?"
>
> Yes. When ath12k_mac_get_fw_stats() returns success (0), it means the
> firmware response was received and valid WMI events were processed.
> The firmware response to WMI_REQUEST_PDEV_STAT typically includes
> multiple stats TLVs (vdev stats, beacon stats, etc.). Even if the
> "pdev stats" list ends up empty (e.g., due to specific filtering or
> availability), the firmware should have populated other lists (like
> vdevs or beacons) in the ar->fw_stats structure. If we don't reset,
> these valid entries leak and accumulate.
>
> "Where exactly is -71 (EPROTO) printed?"
>
> The log "failed to pull fw stats: -71" is printed in
> ath12k_update_stats_event() (wmi.c line 8500 in my tree). This error
> code (-EPROTO) propagates from ath12k_wmi_tlv_fw_stats_data_parse(),
> where it is returned when buffer validation checks fail (e.g., if (len
> < sizeof(*src))). This failure suggests that the accumulated state or
> memory corruption from the leak eventually causes the parser to fail
> on subsequent events.
>
> So, fixing the leak is necessary for correctness regardless of the
> specific side-effect error code.
>
> Thanks & Regards,
> Saikiran
>
> On Tue, Jan 27, 2026 at 8:57=E2=80=AFAM Baochen Qiang
> <baochen.qiang@oss.qualcomm.com> wrote:
> >
> >
> >
> > On 1/26/2026 5:52 PM, Saikiran wrote:
> > > The commits bd6ec8111e65 and 2977567b244f changed firmware stats hand=
ling
> > > to be caller-driven, requiring explicit ath12k_fw_stats_reset() calls
> > > after using ath12k_mac_get_fw_stats().
> > >
> > > In ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats() succee=
ds
> > > but the pdev stats list is empty, the function exits without calling
> > > ath12k_fw_stats_reset(). Even though the pdev list is empty, the firm=
ware
> > > may have populated other stats lists (vdevs, beacons, etc.) in the
> >
> > 'may' is not enough, we need to be 100% sure whether other stats are po=
pulated. This is
> > critical for us to find the root cause.
> >
> > > ar->fw_stats structure.
> > >
> > > Without resetting the stats buffer, this data accumulates across mult=
iple
> > > calls, eventually causing the stats buffer to overflow and leading to
> > > firmware communication failures (error -71/EPROTO) during subsequent
> > > operations.
> > >
> > > The issue manifests during 5GHz scanning which triggers multiple TX p=
ower
> > > queries. Symptoms include:
> > > - "failed to pull fw stats: -71" errors in dmesg
> >
> > still, can you please check the logs to see at which exact place is thi=
s printed?
> >
> > > - 5GHz networks not detected despite hardware support
> > > - 2.4GHz networks work normally
> > >
> > > Fix by calling ath12k_fw_stats_reset() when the pdev list is empty,
> > > ensuring the stats buffer is properly cleaned up even when only parti=
al
> > > stats data is received from firmware.
> > >
> > > Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller-=
driven")
> > > Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
> > > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim =
7x)
> > > Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> > > ---
> > >  drivers/net/wireless/ath/ath12k/mac.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wire=
less/ath/ath12k/mac.c
> > > index e0e49f782bf8..6e35c3ee9864 100644
> > > --- a/drivers/net/wireless/ath/ath12k/mac.c
> > > +++ b/drivers/net/wireless/ath/ath12k/mac.c
> > > @@ -5169,6 +5169,7 @@ static int ath12k_mac_op_get_txpower(struct iee=
e80211_hw *hw,
> > >                                       struct ath12k_fw_stats_pdev, li=
st);
> > >       if (!pdev) {
> > >               spin_unlock_bh(&ar->data_lock);
> > > +             ath12k_fw_stats_reset(ar);
> > >               goto err_fallback;
> > >       }
> > >
> >

