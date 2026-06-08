Return-Path: <linux-wireless+bounces-37476-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MWNeIk5bJmp6VQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37476-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 08:03:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5E653027
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 08:03:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nkvza9R+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="BAgY/tNk";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37476-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37476-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF61300915E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 06:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C912EDD69;
	Mon,  8 Jun 2026 06:03:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267E34F255
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 06:03:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898616; cv=pass; b=Yn6S8qnRV7kZlQo13u0xXimAF/xe7U7yzb3EOyg1cIeDeiT7gRpLOKcm8iC9aT+BdJghPtpiT35OTEOUPLxvlLllSfkxgflWVguAWVQlz8utOd6v//Rc28fcAEJeRL0gUqBX5KKLFkCgak9VfXEcRUL5n/qtbdmd8wNafjM6uD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898616; c=relaxed/simple;
	bh=L4gB2CyfZZju2h7j/pSBKFwKlnP3fthsY85cUyGxtLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lqm3ypzqnk0PfgdLortzU+ndQirdFaH+dGtMmkfKLkFgNK5mcs9WF8nMYX9k2HYVT+fa+EuAzz5by/bUQa9KBchVDxamVptJQ5iDDxoZ+SFvWSiknR7NOnwfPpj+pKSaHdbP6w0YvzJXbXyWEoeoZAlomIobJrApx4xCCHeBWAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkvza9R+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BAgY/tNk; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580FuFh2005223
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 06:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KtG0uM4rhmMQQvtWIMaA5CSqnNNs3fvKYxH3bxEulUM=; b=nkvza9R+kdit11yt
	XmpG79L33/DwCp6WVp7nOT4bBggMgSy8RR3ghno3bBGUNJytxNMgDawIPaliLKIu
	lsnpx0C6GlFWI/2QAPErZpz7Da6jpTJo5KZOUrvtE0bQ7wDf+msxXRE+xuEkhyOD
	3YdIJgtDuBN9u+3f+qonR9R2OjY9joXveSfdYKNwjV4qBkWj8ANlI/9qGOEQkdPt
	kgRdO01aoNhu1VD0zmFpdK+2ns8g2WPrlrNE88GkO/gzC3YUJUKhIFlmKJH4iYwc
	CzCZIN+kgz2mTSpjhpBqWoXNJwvC1xDtjRohLat91vjBERMon3kqISIG1srAfAZ2
	8nxHzQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w67gp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:03:33 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-137daa666a6so565542c88.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 23:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780898612; cv=none;
        d=google.com; s=arc-20240605;
        b=OVdRhW3DeoaWU12jLvI+msFDktcgeh3eP18QyuAJ4X+1bm7X1Crmd5waHJe12bwGsM
         9tSK3JtkxsrgNDCMlgc3fceV0FPkqC4HiOorNGFPi0lzPU86rZmXM49CvS9XYsnVjbn0
         JiMezWtSYyf70La3rtoDDuFNSpiM/0dmAkZeemPHX7NoDimCPWR5vJXnOf6sHx1IQki5
         MEwMn8b6JAmccm5NeBZlgapjPIGA0YSzWOn4wGkHOTEoRxDRvPpy84aAFuO7lFFNZ+It
         I42wUY7NqP03z2OLhMiQ+XRBt4lYrKBIn40cCwidz3L5CKFb9wls5PMLxOx7tJ1IRRq+
         BYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KtG0uM4rhmMQQvtWIMaA5CSqnNNs3fvKYxH3bxEulUM=;
        fh=1xjPw6f7wouP0EMNdtSEsir8c4DXNZ+/vjzcRwHdCZQ=;
        b=UiXukpjjXVdFqfZb2XVAJWaKa3Wojw/9c3lLcYYdKnOUcQo5C6dXwfENfguwijxf8h
         GGv/EFPav0+RWcRe3LVtJDkyK4q5rzHQg8OOV3IfpR+O421hafFhjMiJa8YBN/SDZtfB
         V56FMq0Q9mQFNKn8rvT18Xw87gXDGv8bJJ/5VzxuLtC97CdIYe/3EZXVLtSxhvdGKmoP
         B23X56FoGpnTlPpE3wgGtlDnehFAA2PB1+8N09nulAobPAKpuqQJe3ijheF0JMQifvHI
         CnqxBHcFQfUQQGNNW99Redgrm39YS5y+aH4ozzG9OaNspsjaCsRJEgJuhN80vPq/ivA+
         oGzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780898612; x=1781503412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtG0uM4rhmMQQvtWIMaA5CSqnNNs3fvKYxH3bxEulUM=;
        b=BAgY/tNk88fmkR8/wuawUWCDYD2IuleLJsnpIPK1HBb5xaidfYE0s+Xnln9BKkgTa2
         4jffpTPz/fP8/Sulcg6/k8DU/cr9BKKPKZuXfRZh8Xz6pHlbtI64lsHHe2mAqqMyxkww
         yGYhm0IjTe0zO5QgSODpFublIOL7LCRmidjPn2klFp+8bZCDfyxY42yuyNUdqIC70Wod
         AMPH2FexGgdqjDhSOfGpyTF9LZ4b0crG0bGoiIlFZ2+QziEntWFxjgNnjCtrxKLkRF+z
         6isMjxiUjnMYGPbTtheWckv+UqIo5C1LFPHgcabTL+nleh9oTwTN+ZRlct6YVsg1kcmR
         FWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780898612; x=1781503412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KtG0uM4rhmMQQvtWIMaA5CSqnNNs3fvKYxH3bxEulUM=;
        b=A/wRDT6HWxZR7ZfemuCXWJmWigIzC3HAmL5IXO98C3IDplhAn95ryyv9X1AGaHkm10
         x+tCq8z1TJURxcCDodZACRkHBrgq67mO3K2VyjafNmmnqwyCA0Y9o3HZIAqOMsaC/Krb
         RDTBAx3i9V33sTO+4J0yI2lC7iHboSu9ZogBHjmg0ZzcgjVSngD+l5cRnJFWbiLvF901
         FlAdnXXgLyoAdGBERUVTHUjdLs38Tjxi+1G+l+4ye53TzylJRm/1vwqurdOafakE/i/F
         V5KPIEkBWFgpKZflfnUQ6+mLxXqbb3tSiOqtkrEOKkIkHM44GfDBBeItSvevXSL6DuoJ
         xjKw==
X-Forwarded-Encrypted: i=1; AFNElJ+RGGetNrfYJXo4Q/uSf5cawqA926FeagjsKFLZCk+zdvJm3IZeS/FnDah1GSAtraKCLaXQX6ih0cbvNHqvZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGMJvtPWMx6P+r+0crnfJYaKHSkQXoEUFSwRe0RMjB9vT5W1hR
	VTJporNC1ldsM/u42gbJoXsRPkovtWEPFB90jph8G27Gv/lwfOUOAA4EgaK3rz/sZfuVck52Sf5
	o3U/BXTPbJT1TXry2RQ6lGsLeNr/rwRJLsBOtNzPzEmIkEErMyPfB1emQzedPhljUjdi843AQSw
	EfmRAoye9pxRCxpScf2JjOoffIhoWlcNuxAi8L2ES8lq2BOeZ1aRDO88c=
X-Gm-Gg: Acq92OEjmTc4qb1+xR4Xmdqb6P127uAeiv2RzLi/LQTXktQZfFaDsXzEgjQWA87jgQm
	3ZH28gWswB0HfzSNWdQ0dwnRih2uOGHQhXOIobApAtsCPGJCTi35VTcJPXok0sZVpdthd9CUmWM
	mKPvgY9X4WYllRqXGsbU36fa/7gdCigOzFaSO8BG82oIIw7EcpYlCYONMJPaHtaxns7fJRDMsMp
	ften9IO3+jWyf8GWdSiUQoNPlY+W4P+9dKtOlX1rnSp0Brweg==
X-Received: by 2002:a05:7300:1352:b0:304:c73b:79ea with SMTP id 5a478bee46e88-3077b576885mr3415741eec.3.1780898612322;
        Sun, 07 Jun 2026 23:03:32 -0700 (PDT)
X-Received: by 2002:a05:7300:1352:b0:304:c73b:79ea with SMTP id
 5a478bee46e88-3077b576885mr3415736eec.3.1780898611703; Sun, 07 Jun 2026
 23:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
 <20260525110942.2890212-3-tamizh.raja@oss.qualcomm.com> <a97dac59-a689-4b9d-8419-2b09c1d106ab@oss.qualcomm.com>
In-Reply-To: <a97dac59-a689-4b9d-8419-2b09c1d106ab@oss.qualcomm.com>
From: Tamizh Raja <tamizh.raja@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:33:20 +0530
X-Gm-Features: AVVi8CfXKWhGPjRErM_0nisldWWQ8Rw5_l-GNipArjk0gJx82rbUzCAoqcHI7oY
Message-ID: <CABkEBKY=GEOkDLS1A+8=i1q0iN1WMrQ1N1AjAS7Ar0KOxj-mrg@mail.gmail.com>
Subject: Re: [PATCH ath-next 2/6] wifi: ath12k: Add support for 4-address mode
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: uJxNsQBi3PIF1LejEwP2oDfbU1zszmbl
X-Proofpoint-GUID: uJxNsQBi3PIF1LejEwP2oDfbU1zszmbl
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a265b35 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=1qolghEAOrdbzapifhwA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1MSBTYWx0ZWRfX4OB3Hmi885Bx
 0ots/fScHBkuLCYovyc3AuUBGOWBNK1eAOLAh2oWZQF/WfodBC1FLIyhfL0egkdoekbbL5U7WhX
 5vBysRo7gQyM6qfrCiDt9cLCsjJijC9gpNwCEy9o+4ty8F8o6yUbuwGDOixUjii2PATlilTX6wg
 9PyUvRLyGI2W8zKLYbZcXqJpG0T0w2Hq0HSPASEsy7pRd5/Yg8/TfZ3zep6TVESJp0bxMhWppVC
 nagIs4VfotA6/VCVCQkczOFCpak/5plpoFi/UuA39ktsQI/VnopNyzsweJ9eAqWTiL/sqLTB6bn
 fmUok5xDeoW9OZltIYVXfvnxF+Wla68XNOzIfTSHWN79YZBOSK+hl2lSOqSBg5fmhiIC9wnQj8N
 B+3zlfuIaefQujrcellkr9IYuHFyG96Xt8GRsertp9+XXcu7QCp8ob2Bt3oq3JpzGj1YIvlJENG
 RV0nq2skoKUy8QsOCVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37476-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9A5E653027

On Sun, Jun 7, 2026 at 9:03=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 5/25/2026 4:09 AM, Tamizh Chelvam Raja wrote:
> ...
> > @@ -999,6 +1007,11 @@ static void ath12k_wifi7_mac_op_tx(struct ieee802=
11_hw *hw,
> >                       skb_cb->vif =3D vif;
> >                       skb_cb->ar =3D tmp_ar;
> >
> > +                     if (ahsta && ahsta->enable_4addr)
> > +                             arsta =3D rcu_dereference(ahsta->link[lin=
k_id]);
> > +                     else
> > +                             arsta =3D NULL;
> > +
> Tamizh, please check the smatch warning at:
> https://lore.kernel.org/oe-kbuild/202606051125.XaYVDQZf-lkp@intel.com/
>
> This looks legitimate since there is a path where link_id can be 15, exce=
eding
> the ahsta->link[] array.
>
The function has the below check at line 925 in the same function,
before the execution reaches line 979
/* handle only for MLO case, use deflink for non MLO case */
        if (ieee80211_vif_is_mld(vif)) {
                link_id =3D ath12k_mac_get_tx_link(sta, vif, link_id,
skb, info_flags);
                if (link_id >=3D IEEE80211_MLD_MAX_NUM_LINKS) {
                        ieee80211_free_txskb(hw, skb);
                        return;
                }
        }

In this link_id has already been validated
- MLO path: explicitly checked link_id >=3D IEEE80211_MLD_MAX_NUM_LINKS
and returned early.
- Non-MLO path: link_id is set to 0 or a known-safe constant.

> /jeff

Tamizh.

