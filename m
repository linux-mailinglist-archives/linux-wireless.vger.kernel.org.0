Return-Path: <linux-wireless+bounces-31783-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M6nBwcQjmkM/AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31783-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:38:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC312FFB1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2467C30117C7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08971E9B3F;
	Thu, 12 Feb 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Scf1JHL+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RdqDlkcv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC57E110
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917892; cv=none; b=Aw7eE/1NJGG6c1qky2IvjjVrT16IuQNChQLoZBSa/A3NT3pYu4k7IiIjFRWVp/iFP1y2h8b6glN7oD8/oSfhsHr5G+1qppt2VTwkAakzOhyKnkucY3CJcJRQxA59jFE3OI9y9ZyahkAOcgKdMK31ow7DhKQEQYfHUqntoSnGNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917892; c=relaxed/simple;
	bh=tTyxFyT9HuhxrRyDZ6szH1Z03RRf172n1PUJtzWtm6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CkUN6DqVd8RM8Z93ZWsRK6t9wqCL1FKbPklPeZlZgKDmzCoYRhw71GvsvHqYphjx9pO0m/0W/fIYQzJYfC16P1FZiucGpzhjtjCtaLDQTehk+A1KFvTuiGfumTK62WIlPk9JB394642rIQZkCTFbfvEW6iMLFQpljpbyzPzzvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Scf1JHL+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RdqDlkcv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CHM6ad2093464
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NWNyAKfL5ECn59F0e4cQzPnaqUDLfSewL8EhYtYIGrY=; b=Scf1JHL+OxWgYAFq
	73sOkzEFvAeBxnj/75iK4MKquSWdj+lFybBt8Ggnc0dqsw6yWJNiJDrX4GSwxSaC
	a+V6G7NHRWs5E02E6o28rYSCmbYoyMp9jT9oyxItRfvhrhrgi54bEL3e66j7vqXM
	xTJjvz0K/fNtto3ivbDysIF+KCMakc4he3gL13F+KnJ8n5pIIpQf/R9r79YbpgBc
	mSjwqP68DzIpBQ78TTNT319OcWYE7IvOAnQO2oXULghYvJ6Hg3glNEx56bTMlZJ3
	/wQICn/Ins+sXW+Lv7ogjul5K1X4HjIvZkl79x1e9IAEQ6e8OwbxPcKSdNsjU9hl
	8vIc6g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9k6y0284-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:38:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba9a159437so81658eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770917889; x=1771522689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWNyAKfL5ECn59F0e4cQzPnaqUDLfSewL8EhYtYIGrY=;
        b=RdqDlkcvQyBjFGUjmor1rWGYgdtiqt7R+IyVWDLx4gtHlJnuKz6jy2ZCfkTJ9A8XxV
         F1uiTNqihDYQJR+4ZWpOD1NvDqzAOiiMmfYjuqdvITatURhy8Qq8UXW3V9F0P4InRpvG
         XbKD1li1pjS7vAhuH+xhkyp1Ltb+uhjaHyL8fWIvoDUr4aum6xqq4JRdMOn5qTLZdXTO
         RzwEnqoIh61E12F81oH/FI46uunIg+ZEcEA1WufhjI8qHL8u+CxeAWR/Gi8XhWs9q2e2
         H9kB+RCpWMQOoJT8x57wu6dcNyxHr3JLWlGjFlzy2oZDUL1FzqCx7jHsNBHQKIKWfAjb
         PM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917889; x=1771522689;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWNyAKfL5ECn59F0e4cQzPnaqUDLfSewL8EhYtYIGrY=;
        b=LFKM6sJrNIfemLPorfvGIukluNgpvNpuSI150fImllltESFTatjpbA+V2Chb2zn/Cz
         XB4MbTqrO6tlwRjc/rnqejA6V1FfeaIAxhy88nbVY6xwO/jskrsaS1VOyyuChLEPyDqZ
         OHZ+aFuL97RynLfY4Zv6gbn8o2mgKk+nY7mUsMtnWIVTbvJEcd+mZutY9sTGd6uAnHjn
         NDmjgkgkYh1oLABjtb0YEg3rZGrJrQRXuiKLIhhmgp3D1RgsSGkF2DnybC810lAS9EXc
         5zBGGHTIo/CrFuv2Yh5oMEQt+/P/65GrKyEDshfi4ouk8JXmogKdjeirPX3nN9Dajg5C
         Fn4w==
X-Forwarded-Encrypted: i=1; AJvYcCW7hgK62guAy5HGwNEdQw7S846q0YYjc5DvHUjD17YQZ/WUBJCWNvtN7gMG62DkemxzeVGNe3f3igdeu0drSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsJplAbouGfOvXg0stkPCCK+QkKlUfnlh5EKPZrUlSeCei8qT
	OmUMF5wI4B39qCPn71nAegwAcxdggwoLhztgSY+4MO42gIagkYFsWMZ+lGh7RpASLdsU0Rho7al
	rPdEf5sK+DNPSoFygjW3C4QX8iilQPtNg98eAcEcI8pAGekXsrflSLNgW4Krgb++lhKxrbQ==
X-Gm-Gg: AZuq6aK9PsJRqwlBbIG6P+uLthyM5QIeomZICffozzncTDrHbxgIysDpHqGhx2MGOrV
	VEm1l0Vdh7c0GYSYA/H8dZr42wvgpfxWxtvPalM29y3VIjUIGUrsIzGLl2R4axnOHEdJtFMQQzI
	lKjYHHp15SoGVcx3ZeiRsff9Hc0Qzlc8q/PCqw3NTMQnr/OT3BBDrB61hisQ7aa6jq36qHNW7vA
	v9aToh/nY83RVvzVSE/CSBFbQOBoN61NH9VSYmKlpsV8P9abLUPOHjCAyf6XBwd0bFrvTn4R2XC
	x8ITS0PEdqWYwjByLryQcUT5dIPgvJCVMWhJYDq0DKU029kCMIgRdMCHdyuizOJHpzo+l7vhvDl
	mwh0rI8H04DHAa9RWcDabfyBpsSubEtT5qS0LP4IXbjUpvyuu25/lrbV8zPQP6ACM3iH41/Bwuq
	7P32dBjJydygktAg==
X-Received: by 2002:a05:693c:3117:b0:2b7:f44a:a6ad with SMTP id 5a478bee46e88-2baac6d34c1mr1344149eec.42.1770917889291;
        Thu, 12 Feb 2026 09:38:09 -0800 (PST)
X-Received: by 2002:a05:693c:3117:b0:2b7:f44a:a6ad with SMTP id 5a478bee46e88-2baac6d34c1mr1344132eec.42.1770917888630;
        Thu, 12 Feb 2026 09:38:08 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2aadsm3921980eec.1.2026.02.12.09.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 09:38:08 -0800 (PST)
Message-ID: <c7646164-134d-49c4-a1dc-0396876455e4@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 09:38:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] wifi: ath10k: make in-order rx amsdu buffers
 persistent
To: Richard Acayan <mailingradian@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
References: <20260210021249.12132-1-mailingradian@gmail.com>
 <20260210021249.12132-2-mailingradian@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260210021249.12132-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NsTcssdJ c=1 sm=1 tr=0 ts=698e1002 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Vb7B9NVO3itwN6NV7FUA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEzNiBTYWx0ZWRfX0zb7Rx7LC5RS
 TN3cuWQ9w9iZ0JB2yNwd6FWASMFVJvYzDa/YSPlB34JaYrkH2wZMOXA687ii+FSZrzPAagmOrsW
 7Fx3avf8e1sWKfgv3TpEuHAsQBlCqOCurepfwqSIauozvqXsYe1zGI+CFIsp8tppDJIoG1xGzzL
 5VAIqfRCHHejSpFFvK/SoPoe2LlpWm5fKQD+wHFlk7opLgWZ5GGYnNPm07IP/3hvtkoZBxSZzHh
 4Tbj+AP+WebN8KJZXc5GuPeErQCWAgJEOJblyw19oyXSW43Fak0oH4Vq5PMciib9LCLZF01j7Gg
 0m0B6q+ZfdexQHb/a5vM9PgXwfkWLGsclUpJRmKzUffpXyheUG5tEDslfiXl0Z6sFvZDE0gNYkk
 FgcKLiLDCCl2wk76U2SYONEMtmVDvmRNoxRGzXwyeRj2NnoHIXhoxWYRhkBy2wlzaLhWftdlToa
 hg0V2Od5WwizFzVFvyw==
X-Proofpoint-GUID: V0VxE85KXhXSQ_iPrxHZSuM82c7V5lKW
X-Proofpoint-ORIG-GUID: V0VxE85KXhXSQ_iPrxHZSuM82c7V5lKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31783-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3EC312FFB1
X-Rspamd-Action: no action

On 2/9/2026 6:12 PM, Richard Acayan wrote:

some nits from my tooling...

> @@ -3299,16 +3302,32 @@ static int ath10k_htt_rx_in_ord_ind(struct ath10k *ar, struct sk_buff *skb)
>  		return -EINVAL;
>  	}
>  
> +	if (!skb_queue_empty(&htt->rx_in_ord_split)) {
> +		/* It might still be possible to handle this case if there is

note that networking code no longer has a special block comment style, so all
new block comments should use the standard style which has the opening "/*" on
a line by itself.

> +		 * only one peer that splits at each given moment. We are
> +		 * bailing out because we should have a test case for this
> +		 * before trying to fix it.
> +		 */
> +		if (tid != htt->rx_in_ord_split_tid
> +		 || peer_id != htt->rx_in_ord_split_peer_id
> +		 || offload) {

checkpatch complains:
LOGICAL_CONTINUATIONS: Logical continuations should be on the previous line
LOGICAL_CONTINUATIONS: Logical continuations should be on the previous line

> +			ath10k_warn(ar, "split amsdu did not resume immediately\n");
> +			htt->rx_confused = true;
> +			return -EIO;
> +		}
> +	}
> +
Just wanted to get those out of the way before I look at the real content of
the patch.

/jeff

