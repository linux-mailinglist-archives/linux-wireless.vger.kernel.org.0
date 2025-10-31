Return-Path: <linux-wireless+bounces-28428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1EFC2316B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 03:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 908354EB549
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 02:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B184311592;
	Fri, 31 Oct 2025 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWpKRBBS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IBa5aZVY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C03112DD
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879563; cv=none; b=hsRX08S+0Bis1MpkyEv9iSHcMR9rxXbsCF69ybCKOn/cB9rmofuR5LBy6MCyKkOdICC+a3y5XP9uUN0vZzDP4G17rr7T/UpuFsYEI91sOqatRAFWo7tKpNze86BLgtE9brl9KrQZ4PTq12LH8McAbGjtDW7uX85TCOKZO9SD4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879563; c=relaxed/simple;
	bh=oLLHQAU2YEzNQABmjELIaj3tCmU7i1oXTOuB6R2iSqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nut1AYzWfyQlYHIpWzaF8drFervmtgzWL2bvkfHNhwXqEw4+YD5kWsOMUQ3y111qLKAcCEJ2vZtJyJwEk8Y1OVJpqowT1shwTCg5Y7hbzPrYnskzJB7v+S//60HsGpYmWy72uRRlYKJ5KyJI45qanu6u4ROSb7DLG3+eaM1SwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWpKRBBS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IBa5aZVY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UKsK59832623
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	up7h5Rt3oEtrg2OPL4ITn4omkUSMHi23cUrvc/cU9zc=; b=AWpKRBBSfB8DS77P
	sKLF2ZXMWnIUYveMCqeKjWe+OSOH4BxMGvQKUGPpKiiNluwu6a5mIUl491twU6k9
	DGOXDVgtJH1VAVqA47j36Et6RDxDIrLuOwwh+Hmg++y65+pgplezZ3bBtVU90khx
	Ra3S3Rk7QcslNaKbQ22Ep1zoPcyOzBpbNLmi7+2jhh/3jcnJ9+kNw78eu9a/HXe8
	dGFZ7F1z0a5qHUFiayDaqoi8TXfr6gc03iEoV34I/aCAwF+CL/K+QaL99Z2gZCL9
	+3m59HMSNbHlHjASiWmNY2dDnP5MRsJD5G15EzkV69WTZiG7jdgQz6/YUrz6yWNb
	mTTnYw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb0qt4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:59:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33dadf7c5c0so1893409a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761879560; x=1762484360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=up7h5Rt3oEtrg2OPL4ITn4omkUSMHi23cUrvc/cU9zc=;
        b=IBa5aZVYdSMG3puaFRKQVk3uZ+i5OY2DrF9djcIO+GgotfBoxzX2WiobmtOtJ7/INU
         xQp8CVekZs+ISM0Wc4ruSlskORQ00XbengipgyyEKuGXThNOK9t9JdjQDXmrWl/ZsAJp
         Fm9tUHbyxUcVuL7iuPii0wyyc2+SX4XoMs1uWDOtJe/eKah5HiVfV9ADV6zKtftr4Fc4
         LaWUHJic3hsIuZgWiL702yumuKNa6X6C1hK6R+mSodvkBmvBbN4uWBY5xQKiSIrTG8wj
         SLqReGwxiNAbbQ5/+VHpIWFTS9tKdp5ZSySLcVpaxmxVaM3KxUuKmybHHbjPHcFyIATM
         QT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879560; x=1762484360;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up7h5Rt3oEtrg2OPL4ITn4omkUSMHi23cUrvc/cU9zc=;
        b=cR0uGbcWHQDp824NwaaxhKbFCMSjdeqpRn+yb4LSQ0olGWY2r+O5LINR+GUU2hFu1J
         uu9Rq5Df22+OmGNqfP9pvPSZi4/vcNMC4+vM8KGoYmUIVMwy6XxhcqXH7ZaUp6zBVq97
         qycxy4kh1K83awZkjESs9N5yq0V7lEguHxCxJ75op1CrpHGWieRf0n6W4mJCqa0wm/jH
         ptcKn8cL3Fk0jWOIUJ9cRXwzz2PgnvL60p4883r91zRUroeL8m6GkM/1iHC7vvj5q5xw
         TpvM6CgZ+uaN8MJdTI5DuuPj+cjEbvnhhsslvKwZ//rSxJWzwDnQnDGMFCRTN5njB8Pz
         z9kA==
X-Forwarded-Encrypted: i=1; AJvYcCUIi/DGMuzrcGMz/zMogqvSZ3trPMkWtEQgRQidH+F5U65dvAvPDKojmTaKr5ot3esuDzOO8FDZgeyVBs1e/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkA1cHu3lUoN38G+xFjVZcfLD3s4Z6YTnfP3izcgWAx+iFVd5
	Z2+6B7fFN7ALE+eSWOZZ2BiF3xbsQkM+hAy8JjAuzOSDhXb0Ak7qaFDXmesAkSlh+TMVE6B+IvC
	YRPGChgUKh/RdaHwlj9EolS35MWZBW/eVukhHUv/qrBuPJeoTTBRN0JWTSDwI+zITxhWsuw==
X-Gm-Gg: ASbGnctzSZ2PU/dT3K9IeM4roG2vRCnXNDnRXsOewWoxUOeTUt9A2FKacAIRjKkLTIQ
	1G355vN0sBXoiegzB097E1mCorjYStUU3jmG35DETtYZuxl7aWICnHHLFVitzxGrRsJYhylB7ZK
	9LT+zqn2BxHBl92jkLnKV6Burpo/iFIkQ02uNT9Lq16mKnHzPUG7QosUCgDy+J8uhkkx1ncew3C
	knsUpXR6KyxkLeatdyeI7/lTGEUPegGw/jUo2lO8J64/WG/HnrxTE+j+jcAMFcm5wbp+iPmfq1k
	BansIyZ/zGV9X1f279h7xEcsfgO+a87aA+k67lbLde/81npC3bPp07VSSNSR17XuMLk6cFmErCb
	6Fd6yXLU7ZMYkglRHKSzhI6+ZI2q78VyGbslj3dKv26H45gHEe0lr//eWzZWt7RKrdDBLyGg=
X-Received: by 2002:a17:90b:2247:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-340813cec4fmr2682145a91.13.1761879559952;
        Thu, 30 Oct 2025 19:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8UZxZTzI4+McEAYXu1qgEJFOfy6TCm9B//jkN8UZOlDMEj9SKaRXt8i5G8maNfGXC5APFPw==
X-Received: by 2002:a17:90b:2247:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-340813cec4fmr2682106a91.13.1761879559465;
        Thu, 30 Oct 2025 19:59:19 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f24ef0asm590142a91.11.2025.10.30.19.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 19:59:19 -0700 (PDT)
Message-ID: <0d7e89b1-b676-434c-bea3-fbf6f5788448@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:59:14 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 5/6] wifi: ath11k: Register DBR event handler for
 CFR data
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-6-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251030043150.3905086-6-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5aVoIHNl5QgZdeguOlPX1ko10Bp941YM
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=69042608 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=73josGCDwRHW2riM0nMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 5aVoIHNl5QgZdeguOlPX1ko10Bp941YM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyNSBTYWx0ZWRfXxA3edDI/eOpb
 YeMgFs4AxTrqbbUMbK5YT+xka9fov1mZdrQ0qJwcXmif5w2E864PldazOZgrS8cy1ZsxBlo5JAt
 baMe6WtjOegVgV2g37QCoE6XyNh7d213YeN17u+r48YvR3gAwcAYZSzPxJ8R2WcdQJStIbr/b+C
 cLVJOQaIQPtUC6MN0zmZV1wWq9XxwknstSLZwsSmxuRstCEtTaYkNGz8gUd/wA8N0gSkj4PXRL7
 wuHEJwdHHxxDR1wMhSQQomeuC7JPEr8qNOi0LUDuKjUNFw0AAnYVK3g1gd47QhYgcddhU6OR/UM
 sxC23ofnm5TEuE5Py9hoRsqCMsHzOy5ntWSCvwpYebgcS+NpOR+yLRvAZNS/lkZKUy5sHq5UDsv
 YKykGIx/KyJYHxq4YfafA74aobm1Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310025



On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:

> +
> +/* Correlate and relay: This function correlate the data coming from
> + * WMI_PDEV_DMA_RING_BUF_RELEASE_EVENT(DBR event) and
> + * WMI_PEER_CFR_CAPTURE_EVENT(Tx capture event).
> + * If both the events are received and PPDU id matches from both the
> + * events, return CORRELATE_STATUS_RELEASE which means relay the
> + * correlated data to user space. Otherwise return CORRELATE_STATUS_HOLD
> + * which means wait for the second event to come.
> + *
> + * It also check for the pending DBR events and clear those events
> + * in case of corresponding TX capture event is not received for
> + * the PPDU.
> + */

please check comment style

> +
> +static enum ath11k_cfr_correlate_status
> +ath11k_cfr_correlate_and_relay(struct ath11k *ar,
> +			       struct ath11k_look_up_table *lut,
> +			       u8 event_type)
> +{
> +	enum ath11k_cfr_correlate_status status;
> +	struct ath11k_cfr *cfr = &ar->cfr;
> +	u64 diff;
> +
> +	if (event_type == ATH11K_CORRELATE_TX_EVENT) {
> +		if (lut->tx_recv)
> +			cfr->cfr_dma_aborts++;
> +		cfr->tx_evt_cnt++;
> +		lut->tx_recv = true;
> +	} else if (event_type == ATH11K_CORRELATE_DBR_EVENT) {
> +		cfr->dbr_evt_cnt++;
> +		lut->dbr_recv = true;
> +	}
> +
> +	if (lut->dbr_recv && lut->tx_recv) {
> +		if (lut->dbr_ppdu_id == lut->tx_ppdu_id) {
> +			/* We are using 64-bit counters here. So, it may take
> +			 * several year to hit wraparound. Hence, not handling
> +			 * the wraparound condition.
> +			 */

and here

> +			cfr->last_success_tstamp = lut->dbr_tstamp;
> +			if (lut->dbr_tstamp > lut->txrx_tstamp) {
> +				diff = lut->dbr_tstamp - lut->txrx_tstamp;
> +				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
> +					   "txrx event -> dbr event delay = %u ms",
> +					   jiffies_to_msecs(diff));
> +			} else if (lut->txrx_tstamp > lut->dbr_tstamp) {
> +				diff = lut->txrx_tstamp - lut->dbr_tstamp;
> +				ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
> +					   "dbr event -> txrx event delay = %u ms",
> +					   jiffies_to_msecs(diff));
> +			}
> +
> +			ath11k_cfr_free_pending_dbr_events(ar);
> +
> +			cfr->release_cnt++;
> +			status = ATH11K_CORRELATE_STATUS_RELEASE;
> +		} else {
> +			/* When there is a ppdu id mismatch, discard the TXRX
> +			 * event since multiple PPDUs are likely to have same
> +			 * dma addr, due to ucode aborts.
> +			 */

and here

> +
> +			ath11k_dbg(ar->ab, ATH11K_DBG_CFR,
> +				   "Received dbr event twice for the same lut entry");
> +			lut->tx_recv = false;
> +			lut->tx_ppdu_id = 0;
> +			cfr->clear_txrx_event++;
> +			cfr->cfr_dma_aborts++;
> +			status = ATH11K_CORRELATE_STATUS_HOLD;
> +		}
> +	} else {
> +		status = ATH11K_CORRELATE_STATUS_HOLD;
> +	}
> +
> +	return status;
> +}
> +


