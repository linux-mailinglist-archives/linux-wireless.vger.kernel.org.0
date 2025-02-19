Return-Path: <linux-wireless+bounces-19147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9849A3C7BF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 19:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E2E3AD76A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD91FCFD2;
	Wed, 19 Feb 2025 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgHsyo26"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CC20E32F
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990000; cv=none; b=j4Y30sDd/975kcTFa6wfJOgkiTxYdoXProkxUO8GY7jENXm64s0osZk7oon60XMiEbtz9xUlBAy/m6rp+u/+/cm/IUnB6tuUPIqALw3nycZ321gDjqhcEvpaQt/9lwCwla5Au2usnGa9jeyvEaz9c7S7zaVh7ExxoI8m7HrNZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990000; c=relaxed/simple;
	bh=mEtO0cik+G6gR6+YV363V80pVWuJSHz7ZQS+dRLkseA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=lLWfbDa85L+C6XTlFxzBSldVTAIX3G0Wy/CWuyn/pFXoEIDY6dZy8Cv7Vexwlf+YttFXDkh7Vx/tE7akwLT9vfovg1esx/ZlcDpVhR8ruWubBZUM4el/fILlROMB5g8pzltMpzaXODXYsvID9hz3w3W6/jLhbckbGE+jxHsjnfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgHsyo26; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab771575040so220084066b.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 10:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739989997; x=1740594797; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEtO0cik+G6gR6+YV363V80pVWuJSHz7ZQS+dRLkseA=;
        b=WgHsyo26VcbkzwubPxSymyBU3pe9BTXbX4dgIYhhQs7VBug5PHD9lE9JdkTyaKX5E9
         j6I7A0bVUxnwTT282LL7jmvb8OTe1kQQvG9eIH/hNb2mGePr/YSuUeCiAw+q9IbBmDsW
         lsm45NJV9hAchfX2rJC5UPmpzx9QdVBE1wZ6wipUrG8uB8p7D5mSWGYFXN1QRcnLjCq6
         alZkgN2N2QHJXZJVOBI3aM6a6EcuPKpcAe3xbayJmHI5PQFiU0Bx1Gz0o610D2NFhfTv
         FXOGSSKT4eO2Px76mkHYmG0eYL8l8zMzbzCl0tm47ODX+mRfIDSAIJiSMpUSN2p7Val2
         KzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989997; x=1740594797;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mEtO0cik+G6gR6+YV363V80pVWuJSHz7ZQS+dRLkseA=;
        b=OCLyuBqzJVv+dIqNZ6s8qD6OGmNIKXOKiVQezW7uHA+dPbWoYCsNILOPLmhHxDWsog
         SkXtQkQxg2CxOlkVKVZcNl9jVTWilXZRgpygQokuluL8XOfMNgdgAzyjw5qn31FdJ0Yb
         y+LDvA2QJivLA1+C8WkX3VJCi1GoeISjFftBgmuj1xPk7qFPh7fPHTbnf2ghiYIfUI0z
         39XqgcutTgBHGOth2Z0EbpFw+o9gndiktLWaSnOzacDfSCLi2oiv1NWVglys47qnc4FE
         1nkskC9mBqw+g8R7WFCg2LXWwchQgjiSqeSyQ+2KUqd22vGAvQTmoPpL3BwZlF28yN29
         6AWQ==
X-Gm-Message-State: AOJu0YwM/maoLk5zAdTwHqjZE1rNDMn+hxWFxmBnXabUpJBnqilBX+vp
	ychapj35i5T6HEEHFR0nN5JRw7/psJ/9iyMhDpR3XIAIioRvqKBc
X-Gm-Gg: ASbGncu7Llqy5lO2zjLq0LZyXJwfKlN+/baTe69JhCyobvSqEJQsTK3/guXa5CKysea
	0EtKO3rezY6Ouic64tyTqDR1sXYefmQC2XMdHXD0Xo7d+q8ZZ8lAPC4AXy+le0q6ksMrs+gYuZS
	5k/gPBdGLAxTaq/gKA1K2Ou1thMRZKMoe67SEoKvSbqwpsoog/MTHAiNWnrGoRcXcZ4qnTHmjsm
	Ovr/KvwOoCRxH4mYLJO0HbK0GMoBCnQCvD7cu+yU4XIyvBPlf1i9zjZDDJNxUu7Yh69uhP/46aA
	/qsS0okVZgLlmFm6FajWhrMUd3XqOkhbZw==
X-Google-Smtp-Source: AGHT+IFEV6bKzI8csoMKmAIqDUO1YBIluo8x/jVyBAB7G02y4p1KEM6EDmpOT4MQXE8OSEN3KF3Dsg==
X-Received: by 2002:a17:907:86a6:b0:ab7:f92c:8fde with SMTP id a640c23a62f3a-abbedf43d4amr27254666b.30.1739989996292;
        Wed, 19 Feb 2025 10:33:16 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9654a6b2sm687074166b.135.2025.02.19.10.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 10:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Feb 2025 19:33:15 +0100
Message-Id: <D7WMZ4TCZKPB.2GBOWXBN8WKF9@gmail.com>
Subject: Re: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in
 ath12k_dp_tx()
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250124113331.93476-1-nico.escande@gmail.com>
 <7e120d90-bbe6-47f5-bf72-c1ee681c97a0@oss.qualcomm.com>
In-Reply-To: <7e120d90-bbe6-47f5-bf72-c1ee681c97a0@oss.qualcomm.com>

On Wed Feb 19, 2025 at 6:58 PM CET, Jeff Johnson wrote:
>
> checkpatch complains:
> WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '5e8a373c8699', maybe rebase=
d or not pulled?
>
> And I don't see such a change in kernel.org
>
> Perhaps this is an out-of-tree change that should be referenced in a diff=
erent
> way?
>
> /jeff

Indeed I didn't realize that was not mainline, but just in our internal tre=
e.
My bad. Honestly surprised this has never been pushed upstream.

So the corresponding patch I was refering to is this one:
https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.w=
lan_host_opensource.3.0.r24/patches/ath11k/207-ath11k-Add-support-for-dynam=
ic-vlan.patch

How would you like to proceed ? I can respin it without this wrong referenc=
e if
need be. But if one of you guys has a better fix or something we can drop i=
t too

Thanks

