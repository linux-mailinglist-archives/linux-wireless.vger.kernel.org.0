Return-Path: <linux-wireless+bounces-38867-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J6NtElzTUWpqJQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38867-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 07:23:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8757405F8
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 07:23:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uMLMV+aT;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38867-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38867-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A1183008D66
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 05:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8E274B53;
	Sat, 11 Jul 2026 05:23:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAA4499A4
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 05:23:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747416; cv=pass; b=au8AEJKN41AyUD9GnyHkdzTXP7pjy878VoG4yjKhqAkh8hCvX7KDwth2rs/v/+m6JPvc9NY7aQhhZdRd5rbmx6ayS8xwBdpSiPvnmnhLjw8OSrRPwE1NsvM6BL79I5Tq3OukwLeMezIlM6ZkJPYq2SFApQ6prgfEUSfvSsuQahI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747416; c=relaxed/simple;
	bh=Vbir7G5U1uaNCQUvONVRUrXkoAxD/zZpwy+1cUqwLTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5n/5VT7ggdGXrHU/bPwkRCvSt+HqG1sq+dI3jK9bc7YB342fB73yI4bbYokWJXbC3fOy+CfUggE8YANNGWDxB6T8pwaH6p9xxGTH7QXY03RJqe+D+NBQ2cQIWVxn4K82nFafFou5EiDJ0UwVBZvCgwGTaEqvfYBQ3W92FtXLuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMLMV+aT; arc=pass smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so3268a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 22:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783747413; cv=none;
        d=google.com; s=arc-20260327;
        b=mKDtHtKWwlOwaJIDUxwW19S4YJo6w55Sr/g/F0FD+ReCqsp4Zu9auNHlSte4e5D+X/
         rV5V1NOFQfvsLAJcg+JCJvc7x6QtryBK3GbmJydQz9nAIGFgoTnicgMmf/Q7rkbxbT5T
         Tyx35/la+WjALFPcj/OyeUw2MXBKIN/B11yItQvGkqh9OxMS0hCvl5UgJeIFDB9Ne83H
         j7DvubbO4co9ZwrSI13MZj1C7nZnTAEYjsUnNT1nTN/NcEhAHKyxwqnJmmWsVMEhaI8D
         xTXe9mT24dYr6dICXdDFqkQWlDf6ELhiMfWhaLwWBc+LeOFvz5bKzyDEBgMLmRlM0NX1
         V7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bAo1f14O296ecX5TWVkmIDxkDvBZ9MYtp70xyOPU0PI=;
        fh=3HSOqQXDCIGhk9xDWtbtDULXO6+S/sKAwtp+tYhATts=;
        b=jHettP0xLQDoKdy/T5QG/GJuQsE5R0GzlwT9acUaGRSBdonicJ5XuHOh32JssBUxb0
         O3SG2gZiDpXGdv0xkTM1osX16RqM55dimrQiu0e/nvRs9RNmh38TJQWNPCPcv1O+E9oP
         eCBe7jm9YO15i2tI7pf5SWPNd0aoR4Id7zqmgNq+VzSd4tZzXU6cy1zEwjwseRJSv0hz
         pfmISD68uwIZR/Ijr0pX9mNtCuto4Oos0Era1lTADKYKxPmhaT9oUKOLS67mMS0X7A7I
         omf7xpk47KcMgJdTMm/8flF3sbCMNxdeeBOOlJsvns9qDCVKSm/fzfeIeqEykMKw2ct2
         2QCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783747413; x=1784352213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bAo1f14O296ecX5TWVkmIDxkDvBZ9MYtp70xyOPU0PI=;
        b=uMLMV+aTWkeWUHipxJyPqLC2MpcMozM30UZCy1jb/ql60bX0tr/2iJAjWKGcYTeWuc
         rBvOBOQF04AjwvOFVSbWvnC8Z5C6zl4df/hbZ1Cyjtczz8dweZCty07TJrb9BqClY1WP
         vnrwQmeH73mLEYg3cnRyrsPLJwnkYIev6mVnyj8de83Ze80EKQThAVSuMYf8012osHe0
         gW8trad3BobyZ4nw3geWCwmmkVGBYrOzKZpywbyj+M/iQ7uSVR2Pajfafm/L+cYkEAts
         vZgYDJbIstw8naA+B1eR7wKyz2hAFz9CshKi2s2lP9+uIXNSqxxy0F6ebq9zlDvZGW0A
         sA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783747413; x=1784352213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bAo1f14O296ecX5TWVkmIDxkDvBZ9MYtp70xyOPU0PI=;
        b=hozZVF6u1JcmGZSi05N4gRQn3uSGcPETEs2/LwxPWWeteGJL4/CZpB88oqtZ+k1ZgG
         yI+JPosSfTzlW6OaVVAlg0hBuqBBjU/bH9y/jmHFiZaY8SZh/zEa13ggbZRtCWOyMRdw
         V602Zo0Y0C2WbvcNLOQhiAzWxlg4ZNNrk6gihBacAj9bkeZutLapnzsHm1Lfl6tVTC9Y
         hfy7ImGmYuf/V5Vy4R2GbWzbzak9MwHVHx/53IgsNUSfjvNXCNfQzeMdXLdnPBxTFC4+
         0oP7EZxcFjFIIzwsJHOb2mC2/t6b6e2fI6dNgRjMBOGfqaDwZRbCa70nRkdBlrcYzJ7+
         sRbQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyXkVaf8txF3/HCnUMJgMT/S1L1ZB5nz8nEKKc40iofLGsbQ78PFOmCs6ygfaqrSvuykwZgHF+Tp60bZmRqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43MUUD+PYR308X8U0ILTKhwdOhZ0ZSVMLRkzBOLiBcLSCX83V
	xxjXmr1pCR0JpmHLLLDBC3qbtYaE+RLckV7NdrJ1u763agvV4XadYs18Sx1oSw6LxUjlvcgwmFa
	ll/ZuSF8WK7ZgpdSPRZuVBLQZVUVrIxQMn7/CcgPM
X-Gm-Gg: AfdE7cmjOdQJ5rm/0Lt4+KIkf6IJpiNd4hRq+cq7jKQ13mkrhCHNaQI80MbQzYDURfW
	R6rZc3YmuTyGGzEk60IlmZTK1NGFXm83uIsdGwLQclPLcRS9Q8YGJ7srLeO6CyAtlV3JSf8SYSI
	pHpiXb3ZvKhlXDZPFhr+gF6DLIRc3LIiAlYEnvdDlJs5CDz+PEHusOafimaGTvRsCDU38qhte8Y
	aXjb0M/fyoajt6M9oskYv+0eyzlluGwfxUrl7/GvlunEW4Sxnpng885rKlTGTYN9P73Up9VbprF
	6sR3lUw+HAEZxTRdE9I6RjrHgz5gplHeqDwtWo/Bw2akrvYReY9a0SBLcB1y3n4=
X-Received: by 2002:a05:6402:564b:b0:697:9254:a66b with SMTP id
 4fb4d7f45d1cf-69c5f806bbdmr32702a12.6.1783747412689; Fri, 10 Jul 2026
 22:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101635.103005-1-fanwu01@zju.edu.cn> <20260710002451.500112-1-eddiephillips@google.com>
 <caae46b1-50c6-495d-94fe-c95229d489ce@broadcom.com>
In-Reply-To: <caae46b1-50c6-495d-94fe-c95229d489ce@broadcom.com>
From: Eddie Phillips <eddiephillips@google.com>
Date: Fri, 10 Jul 2026 22:23:20 -0700
X-Gm-Features: AUfX_mwj7DPyIzPgMc2aLdczV-n7IZVIQgU2ji0mGrRtnih3_s-rWd9eqlLTuGM
Message-ID: <CAPBb8HnN2Q2_aMRQ5Tv=pbi6Mz=Qe3CJkAucUx858_+_AW4efA@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Fan Wu <fanwu01@zju.edu.cn>, Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	Chi-Hsien Lin <chi-hsien.lin@infineon.com>, Wright Feng <wright.feng@infineon.com>, 
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:fanwu01@zju.edu.cn,m:aspriel@gmail.com,m:kvalo@kernel.org,m:franky.lin@broadcom.com,m:hante.meuleman@broadcom.com,m:chi-hsien.lin@infineon.com,m:wright.feng@infineon.com,m:chung-hsien.hsu@infineon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211-dev-list.pdl@broadcom.com,m:SHA-cyfmac-dev-list@infineon.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38867-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eddiephillips@google.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[zju.edu.cn,gmail.com,kernel.org,broadcom.com,infineon.com,davemloft.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddiephillips@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE8757405F8

On Fri, Jul 10, 2026 at 12:18=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 10/07/2026 02:23, Eddie Phillips wrote:
> > On Thu,  9 Jul 2026 10:16:35 +0000 Fan Wu <fanwu01@zju.edu.cn> wrote:
> >
> >> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
> >> drvr->bus_reset, whose callback recovers drvr through container_of()
> >> and dereferences it.  The teardown paths free drvr (brcmf_free ->
> >> wiphy_free) without draining the work, so a bus_reset callback pending
> >> or running during removal can outlive drvr.
> >>
>
> [...]
>
> >>
> >> This issue was found by an in-house static analysis tool.
> >>
> >> Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> >> Assisted-by: Codex:gpt-5.5
> >> ---
> >>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 13 ++++++++
> >>   .../broadcom/brcm80211/brcmfmac/bus.h         |  6 ++++
> >>   .../broadcom/brcm80211/brcmfmac/core.c        | 33 +++++++++++++++++=
--
> >>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  6 ++++
> >>   .../broadcom/brcm80211/brcmfmac/sdio.c        |  6 ++++
> >>   .../broadcom/brcm80211/brcmfmac/sdio.h        |  1 +
> >>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
> >>   7 files changed, 66 insertions(+), 2 deletions(-)
>
> [...]
>
> >> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b=
/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >> index fed9cd5f2..b934feb9b 100644
> >> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> >> @@ -1164,6 +1164,35 @@ static int brcmf_revinfo_read(struct seq_file *=
s, void *data)
> >>      return 0;
> >>   }
> >>
> >> +/* Serialize bus_reset arming (debugfs reset write, brcmf_fw_crashed)=
 against the
> >> + * teardown drain: the remove path takes bus_reset_lock, sets ->remov=
ing and cancels
> >> + * the work under it, so a racing armer either schedules before the c=
ancel (and is
> >> + * drained) or observes ->removing and desists.
> >> + */
> >> +static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
> >> +{
> >> +    mutex_lock(&bus_if->bus_reset_lock);
> >> +    if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->remo=
ving)
> >> +            schedule_work(&bus_if->drvr->bus_reset);
> >> +    mutex_unlock(&bus_if->bus_reset_lock);
> >> +}
> >
> > Is this safe in a softIRQ context?
> > mutex_lock() sleeps until it can get the lock.
>
> What softIRQ context? brcmf_fw_crashed() is called by PCIe (thread) and
> SDIO (worker).

Yes, you're right. Since it's thread/worker context, sleeping is fine here.

> >> +
> >> +void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
> >> +{
> >> +    mutex_lock(&bus_if->bus_reset_lock);
> >> +    bus_if->removing =3D true;
> >> +    if (bus_if->drvr)
> >> +            cancel_work_sync(&bus_if->drvr->bus_reset);
> >> +    mutex_unlock(&bus_if->bus_reset_lock);
> >> +}
> >
> > How about if brcmf_pcie_remove() calls brcmf_bus_cancel_reset_work(),
> > takes the lock and calls cancel_work_sync(), sleeps. If debugfs
> > path is already running, it can invoke the worker thread. Is there
> > potential that both try to reset?
>
> What is "both" here?

It may be possible that the worker thread is running and then the device is
unplugged, causing a deadlock.

Another possibility here would be to just lock the state change, but both
implementations should are fine.

Best, Eddie

> Regards,
> Arend

