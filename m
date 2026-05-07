Return-Path: <linux-wireless+bounces-36049-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c8b9LHjc+2mWFwAAu9opvQ
	(envelope-from <linux-wireless+bounces-36049-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 02:27:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8AE4E1B18
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 02:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A417B301EC76
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 00:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854019992C;
	Thu,  7 May 2026 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/Hh4iF5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85F22F01
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778113652; cv=pass; b=OFh58zYRuWqPX+kDzohDjcHw4sm02wAhEA6ajzABLK3NwKi51OqdrcZT2il+rDLA+RjHcdkWDZHLjv3x1DilXcOrFdCg0gg7gcEUK0/TdmTEKhpSPnef+Ae4um0RHRkTfcdNafLHUMa7v44xXqd46BD76vXwCX60TPrTqZ0aG3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778113652; c=relaxed/simple;
	bh=9JZfN96PNIe6LE4i5O13JZ17EyVtZk4l02ryHyBoEh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAbZqzurAO7v88g+2ANrULM/mPjTedt1WkNsEFaDPZnezDbx6n+Q90dEOGO3p/qtzEubX9oKL/T1vL3isosOUfd5eUPo2PL44O5VPIFIHkdiXmZgiBu5L52I6o6MIXL8QhNkyjvYFMwoQkN8xQJ0CC1/DUCGgI3SOZ+bBjV435I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/Hh4iF5; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so214146e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 17:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778113649; cv=none;
        d=google.com; s=arc-20240605;
        b=bdQbtKl/4NUL9pvcC4OwtJTVnL9PTfN2ply103pAPdnqnZX/j3hj+RzlEsG+zdGX1j
         tVf/M61LFkm7vCyZPnKRmt0CC68MDdH7TcNQap1s+Nres/c9REcjBbNQdolBYzzO2Szr
         TkPYP4pHq4jPkrXJDD0X7D12wKvULk+65qNhnFgb4l2NSz0oixkzdCFSSyLOj3pNmQXH
         RCOI/zzIM0WMGHX4wT+itsvHET3AwgSoGQkhJnEBNHGVkAxGI6+bJ/91/apWFt9bBeDx
         fe5UE3HJ762HDbLP9IPzTvd1OZf7iy9f1ebP6HWOJ5cvsA9URnK3fMLR4/kafyZOiMco
         MSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JNLigKdON3N83dexsL9iAr5dG4JmFlZysFA4uQx/JUg=;
        fh=G5GqV0TTXv9b8htMgUGO8C8DT7csmHAvbNkRzn3nOyI=;
        b=VIjNr6uLFD12zsQ8rmYGmjnpDtYhDkrsjBG4Vb0+VXuCEcgp9BUNtoXb6Spay6daAx
         ikUjzV9Hy6iaiOEbanX15HHrO01UuFq956jW7CK+kmCxCkgas5r/yYf0TOazM10W8PW3
         h20k80MHBwKmTwFuo3/vqyhLSQnKpCgflQAT1LBD2mIDoxf0kNBUPVnvAiEkGUIz0/Vw
         IkswzgfxKvih+7Bpzh9cb5NdK5p/m4AfvsWsC9kuCl1K1ZYE5f6JF3lpHTBTzaP45eVa
         T9xBvpFatACyVrhsS0BBlfRcyWGUtH8EQYGHHZF1QDR7Tfh2wbjeo0zux+flqaBSE78G
         vKpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778113649; x=1778718449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNLigKdON3N83dexsL9iAr5dG4JmFlZysFA4uQx/JUg=;
        b=N/Hh4iF5LnPKx8LzRs8i7huYmxBZoDRl7fZ7o9Uhfyd2Dy3OHUOMZUB4163lLtZaP/
         pB89THjuHKt7pglsmn+1o9hAqD3PS/nG8noiuT3MHg++ZxTt0MFu4+ygbLn+tRS33wn4
         0eEXWI2A37MQzccAqObNLxECILzK8f/uH10obDwcf6q8JpVJm/hUn6BJaeFgZ4Jf+Mg/
         RgTJ2ty+NYHFIp29H5qjcA1l0o8fff9p7F4bbMLY8ecaKmp9OM7fgfxvxDJZNGTIndNt
         YiJb78U7nni19dYOLXZnJBuynHT6aWvkE/u8ZmX7KV6fsXgpmW72oq59xlHytv0ijyYJ
         dWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778113649; x=1778718449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JNLigKdON3N83dexsL9iAr5dG4JmFlZysFA4uQx/JUg=;
        b=go1oc6yyfBjQruO2l02qJn8onBt2MZuNtnKOxEQxxjmXCP2ImxcsxwWkRzMq1EX6T4
         EmGrr3cbxMvNZemG3UUTcx9PC6WFJINowPPWlJr7GoW2D2x32AJhBjcHa6PLf+8nsUy3
         DvEr3ALxbvibBpxUzZUnrtPYXvdFiXPOK20QUTYiZ8G34WOi15gofjzjhB9Ixq+YpjWn
         BrMZYPeAxAAo5upzgDjDgoAWTh2QWyjgkKLGZkDDV+9ttIk3d4dEnhbDvkoETxrN+QeT
         vqIPwdwA9ajQ9LCEzqLvw2ZvuwZhPGvIdhD+D8FItE84uIuSRoHjPzJ4PVVRTrRlp4vU
         T+hw==
X-Forwarded-Encrypted: i=1; AFNElJ9C2T6ZtJj7lueBZkA6wZ3Um23rtrSmPu9DWM8Q1OeRTgSd7+2OZhc10vyw171reoDHADxfSbuj9rea48L83A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYrAA8EK0oURiNnamUmTxh2NHehl4jyQSH9bOZn3mu6zPqaFr
	44QcP41vLPh/rQQn3BHXtLX/WwzUYNxBkfFp3NEWpEI2Ib+2Jqczk7YpHbu5QNNsBF3y12wlEPL
	aYcgGlxO7zQ2Msc4edjBLMmVbRJ7twzU=
X-Gm-Gg: AeBDiesGgxXrZdt550os6pQQm3kbwQikivG2g00HpdOyclHl1N15gmBJ56OX/r732Ia
	El9I0x20AgmYtkyRJS1VMfujLoowSzzlf3czRa904xqAqbnTe7XFKEX6oyNAJ18W1KnzU+FhRkq
	Z+/XoYziRbpgZ6NUaY4zOUoVHpCTdTPUC/79UGESrDAbPp+TI3BI6T+0Pubff7/1k+1dMxYWQxB
	KmR4gfsCf2D6YF+rJweuPTPBenXrGJ9VrdUW2wXbQ8nG//E60o+S7CyWH9wVuCDKIHD95TM197P
	D3ZyndBmQW/vUt+06g5Swn00xMRh
X-Received: by 2002:a05:6512:3d03:b0:5a8:99bd:12dd with SMTP id
 2adb3069b0e04-5a899bd13aamr190899e87.31.1778113649155; Wed, 06 May 2026
 17:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=rq5ww@mail.gmail.com>
 <20260506200918.D68321EA006C@mailuser.phl.internal> <CAGp9LzqkJ8QoOnBAiGu=uum3-LmCB3yHr91sw1HoLw+7ewNx6A@mail.gmail.com>
In-Reply-To: <CAGp9LzqkJ8QoOnBAiGu=uum3-LmCB3yHr91sw1HoLw+7ewNx6A@mail.gmail.com>
From: John Henry <jshenry1963@gmail.com>
Date: Wed, 6 May 2026 20:27:13 -0400
X-Gm-Features: AVHnY4LUug30DwDnNEf_34lgWqQd9BfnsaygUSMtcheO-lYYpws24QzLgvDGg5c
Message-ID: <CAN6xzWfOLLjA1dcLZ=eugjh7iM7KK30iG8U9QOPAY0GoqxP8ug@mail.gmail.com>
Subject: Re: [bug report] wifi: mt76: mt7925: iw set txpower fixed accepted
 but ignored
To: Sean Wang <sean.wang@kernel.org>
Cc: Javier Tia <floss@jetm.me>, Bradley Pizzimenti <brad.pizzimenti@gmail.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2C8AE4E1B18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36049-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[jetm.me,gmail.com,vger.kernel.org,nbd.name,kernel.org,mediatek.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jshenry1963@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Sean,

Thanks for the pointer. I read through the patch =E2=80=94 it addresses the
txpower reporting / display value (iw dev info showing the correct
dBm), which I think is a separate concern from the issue I reported.
Please forgive me if I am being presumptuous on this issue.

This issue is related to monitor mode retune's of >=3D 5 channels.
retunes of lists of 4 channels or less does not exhibit this issue.
Neither do I see these strong "RF Ticks" in managed mode.

Maybe a bit more clarification or other....
The behavior I'm seeing is a real very strong RF emission at channel
frequency on each retune, observable on a fast spectrum analyzer. It
only occurs in monitor mode and only when the per-channel-set sequence
touches >=3D 5 distinct frequencies. The same chip in managed mode being
driven through the offloaded scan path (NL80211_CMD_TRIGGER_SCAN) does
not exhibit it, even when sweeping the same set of 5+ frequencies.

Reproduction with stock iw commands (no custom code):

IFACE=3D$(iw dev | awk '/Interface wl/ {print $2; exit}')
iw reg set US ; sleep 1
ip link set "$IFACE" down
iw dev "$IFACE" set type monitor
ip link set "$IFACE" up

# This triggers narrowband bursts at channel center on each retune:
while true; do
  for f in 2412 2417 2422 2427 2432; do
    iw dev "$IFACE" set freq "$f" HT20
  done
done

# This does NOT (only 4 frequencies):
while true; do
  for f in 2412 2422 2462 2484; do
    iw dev "$IFACE" set freq "$f" HT20
  done
done

Bursts are ~800 kHz wide at the base, -30 to -50 dBm OTA at close
range, brief (estimated few hundred microseconds), at channel
frequency. tx_stats counters remain zero throughout. Behavior is
identical on a custom mt7921au board and a retail ALFA AWUS036AXML, in
an RF-quiet environment with no other 802.11 / Bluetooth devices
present.

The strong mode dependence (monitor per-tune yes, scan path no,
identical frequencies and counts) suggests the firmware is doing
something on the per-channel-set path that the offloaded scan path
skips =E2=80=94 possibly per-channel TX calibration. Is there a known firmw=
are
operation triggered by the monitor-mode channel-set MCU command that
could produce this, and is it suppressible for passive sniffer use
cases?

Thanks,
John Henry

