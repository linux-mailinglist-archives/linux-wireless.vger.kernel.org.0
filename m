Return-Path: <linux-wireless+bounces-37302-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YiZHGGf1HmooaQAAu9opvQ
	(envelope-from <linux-wireless+bounces-37302-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 17:23:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C5062FB66
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 17:23:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="BHY+9/iE";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="H3Br/Id7";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37302-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37302-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 677BC304A3B7
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBAD3F2101;
	Tue,  2 Jun 2026 14:44:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753893F0773
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 14:44:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411486; cv=none; b=XFNrtjtdM62F/mEinPTBrltC88zhKwBQtBLR0F3fFb1+OOltX6shsy9Xhb0BFZSZN824ZQIh1Wull+xSBZ/WZJciLhrcH+x/wlnS3LvkRoUMKiiclVUJe9PTauJliWxgYWj3loDxa4dC6fPuk4QrQyb28Eva4Di3EnMX+EmRqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411486; c=relaxed/simple;
	bh=JGSh5lAZ01h4V6/aN5YEeVciZCInCwqxQ6QqUvPGo90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiAxSmjzfeyD9OBCCoFDFq8eTk67c5ttMBM0162PHFrr+ile8VX6/k6lh92XlvxhthJLRlQ62zcklVDbxxgwM6QAGtDA2pwCCsqSCxT+Kl36zjtSoAqF/XJX3jdwziJwaLdGUlkpGLpDWMt3zyuxEQYirMOSmPStouWP4LWeUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BHY+9/iE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H3Br/Id7; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652EU8rd1638466
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jun 2026 14:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=g1qut49VqY6kixKrk363RsT3
	75KtaT3Dj3vgJwsvmMA=; b=BHY+9/iEQsfwnfFkozleq2w3xaPvI9jJpUfv9NRD
	9vIuRgUkEvPLCPdiWlD0M4NVxPar7XJqBHX4V5nxT8LBDbkSj9a7EdiFSxfibu7V
	btJRt8ioDdDgKZOLU0OI7HpcS/JQatOecRMeGvWtK1KsvB+fE2hPsb391s4Toy5I
	Yea+abZIfmOPW79A3oHkW+Sm1/g7zGEdL2BHAvgZBj/1otg1Aey735G/FaYIojVB
	xuH+jYHnuo3x3bmzFL2b7vU43vjZUpPmrjyj18jiDqZlAyT6hokevSB0pCv5sEUp
	UUbz0NIZ0Wgb1ZAevQh2KqNKDCXgzu+9TsDjpXfBbuZY1A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu1chmcr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 14:44:44 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6751db2792dso4585782137.3
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780411484; x=1781016284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1qut49VqY6kixKrk363RsT375KtaT3Dj3vgJwsvmMA=;
        b=H3Br/Id7H4q/WFdNqFVVAorPjfN6UEJ4r4YMHg0Gx4TzIR/6OaXh5HlzR3H3XW5Jkw
         Ya7TUhMaGQxRtzBAB/odYY02eHuVew1SwaQzQPlpFDb89fOIE1eRtDXdc5tCgAN1TRp8
         0/AoGwMzt9yqElQ/B6QDWUVdQajBLw74TCAj0KWhL1sp1N6AQQtX6RpM9461EL9W3xE3
         xqgxirZTPYQMxH7sKI+BGwX+t8m5dmZKOZ6jG14zK0rzq3Xl6vO2kGToWXRPSJ17+my9
         l4wcQkTKEvP3k9IEje3sQARCilLHAc5QORGfNbUV3ApLHWEDWsL0GMKBmB8dt8Jfbbjc
         Qciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780411484; x=1781016284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1qut49VqY6kixKrk363RsT375KtaT3Dj3vgJwsvmMA=;
        b=rIBLqYMjTae4UUKmzqDFwcaRjUShNL5TcRIaTbWV4EQJ34wdE/TaK46rfPhtbWER4q
         w0F/xQmmDNJqKUzUGMcuoAA3cbGoasMtMQlTrus1PwB59Kd6zmNpyZeMrSPseeG0WahN
         7wKfBJTr/90xIOyf4jWQvTa9K6yLvfrbbVBG2WwpzZII2Yc2cs6Om5wxo9OI6LGbXXoZ
         HKkBkwO5feyIZ3+zTh/08MRMbwBa6DVWlw5kwBNPDjDpKxAeswiSn5SrAc5MidJqctrZ
         C/98TRVGn6wnOKGjYwYTZ6d66+vh8Y04IsEPPqGP8OQVtphAXWzQRTES26AhbYxSNaE1
         BHxA==
X-Forwarded-Encrypted: i=1; AFNElJ9WdvdumvQarDqPVnJ8fFWn7EdQZEvSwrH0Ts49M9FFAHxkF64/8ce7kwGL9yy4S1F5nj+GRNZ4mHm5u4MsHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YylHHhy77LeQkMaTRDfxwyOetR+ZJBfk1QXMXZbpgUidUMzM7jP
	38oBHTfUrqdlozl1GMEPwOvEecGlBxquandjfH6a/JoudwcKYCcuBBDeUkvDwyKFWIzWctsBxWj
	Y2YDCWcLak5HtKYiuVvAEh0xlHEwY58f4D1z/BaSC+rCihTc+02HUabSk7nD+engfUwCjIA==
X-Gm-Gg: Acq92OE7F6BilwHPjzEQLY6VrAsayqCh1TVoHvpS/lH6e1qJN71mNv7W0sMEBm3SOvu
	CDyHXzQliZyrmdjPFj91N+jMPE/hjwdFhKfq8Fo9+YT+Hj88km1n8+vFiGmpoVGHMtnxQPT2aBV
	IGnQvpQIxnDVCpFjKOxMDXhIK2BPIHiMDd2XzutpUoXvyjiC1QPSAaaQ/rKcXccSK9nNx9o2Tci
	MOWM1w1UTm0+Gl+5yX5iJ47tbDhf61lM7JKZ398Ha9TVZOF/aM8KDl9IXoWVC3pxqIwVvTAElKu
	mJxwAG40hv7Lr7PBFywP7YXKY7DPLJkIc5/vsu/TAzXnqJdsT3vCyyMpyLmCtmfm3uMoSgLTb32
	7fo7ZF/onMUS1q8tWLMpyWLKqaA+xHkT8Dbr7/o06COqjBz9x+Wo4MXlHvtEx55HIp2s=
X-Received: by 2002:a05:6102:3753:b0:604:ec90:ba14 with SMTP id ada2fe7eead31-6ea1ff9867fmr51530137.11.1780411483781;
        Tue, 02 Jun 2026 07:44:43 -0700 (PDT)
X-Received: by 2002:a05:6102:3753:b0:604:ec90:ba14 with SMTP id ada2fe7eead31-6ea1ff9867fmr51511137.11.1780411483296;
        Tue, 02 Jun 2026 07:44:43 -0700 (PDT)
Received: from QCOM-LDTZRie9bq.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e03709sm1166066b.30.2026.06.02.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:44:42 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:44:40 +0200
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        thomas.weissschuh@linutronix.de,
        Arthur Kiyanovski <akiyano@amazon.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
        linux-wireless@vger.kernel.org, linux-sound@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [patch V2 16/25] virtio_rtc: Use provided clock ID for history
 snapshot
Message-ID: <aupnwe2y24oxejpkjnlbzlmdiuuzlbqlahofgzipxwsnoir4jd@cwgplvoe46ok>
References: <20260529193435.921555544@kernel.org>
 <20260529195557.744271454@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529195557.744271454@kernel.org>
X-Proofpoint-ORIG-GUID: RAwUKhqZMI2xIbneFJZohNQcDGc4E4bb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE0MiBTYWx0ZWRfX+yb2OVaRqLhJ
 Iu3KXH7iOHuKIGLJTBR2rup8CVjEMhdGhG4aGNrFaw1MUJA4iahvZmuzsDW7VuAV/ISYX4FdmXx
 uKmgWO/fDyxAIk886Brij3vzZrI2lyDjbFhWdmbgnAG+HTfYKqp3ZsY8PeTzFNkL2PBeindOAeu
 dWhRaVnM2Gxu581Oa7iqTOEjldcBeu/VAtUN3tYOsK1MXN49HngZGf8uNBSgMFXCI1dGGktotfj
 ee85eZKRF0H2IMx3CFHdiQ75noka8/Q3rjcfr3gu3KDKGylM2yGGBKfVFfF2hsXYxvWBXHHDEF3
 FrxsVJOmULsBf5YoNESYrt5WxE1zXqDWhzcQ65V9JaO236NRt2fSlyRvxJ8szKCicOAko2h3v8p
 TuYao7fpcevrlbik4NhPKtph01KBixfrb7qCKgvFApecCIYZlQ8rV/C8w5FTQlhiSyHyINAC/tZ
 mAByxWhIuF9w4P+bMhw==
X-Proofpoint-GUID: RAwUKhqZMI2xIbneFJZohNQcDGc4E4bb
X-Authority-Analysis: v=2.4 cv=O6IJeh9W c=1 sm=1 tr=0 ts=6a1eec5c cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=pBOR-ozoAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=KhUNALZX6FJHKvLdx2oA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020142
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37302-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:mlichvar@redhat.com,m:jstultz@google.com,m:sboyd@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:thomas.weissschuh@linutronix.de,m:akiyano@amazon.com,m:giometti@enneenne.com,m:vdonnefort@google.com,m:maz@kernel.org,m:oliver.upton@linux.dev,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:tiwai@suse.com,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:saeedm@nvidia.com,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-sound@vger.kernel.org,m:dwmw@amazon.co.uk,m:vadim.fedorenko@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[peter.hilber@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,amazon.co.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,cwgplvoe46ok:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.hilber@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54C5062FB66

On Fri, May 29, 2026 at 10:00:52PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@kernel.org>
> 
> The PTP core indicates in system_device_crosststamp::clock_id the clock ID
> for which the system time stamp should be taken. That allows to utilize
> hardware timestamps with e.g. AUX clocks.
> 
> Use ktime_get_snapshot_id() and hand the provided clock ID in.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Acked-by: Peter Hilber <peter.hilber@oss.qualcomm.com>

> ---
>  drivers/virtio/virtio_rtc_ptp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> --- a/drivers/virtio/virtio_rtc_ptp.c
> +++ b/drivers/virtio/virtio_rtc_ptp.c
> @@ -139,7 +139,7 @@ static int viortc_ptp_getcrosststamp(str
>  	if (ret)
>  		return ret;
>  
> -	ktime_get_snapshot(&history_begin);
> +	ktime_get_snapshot_id(xtstamp->clock_id, &history_begin);
>  	if (history_begin.cs_id != cs_id)
>  		return -EOPNOTSUPP;
>  
> 

