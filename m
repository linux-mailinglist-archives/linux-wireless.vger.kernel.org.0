Return-Path: <linux-wireless+bounces-36718-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GENUMmcUDmoW6AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36718-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 22:07:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967159927E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 22:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11E9F33319AF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919783F20FA;
	Wed, 20 May 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WaiPV4HE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WwUBERFY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27E339844
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296344; cv=none; b=MGNXstpcBcwQiYkUsnBpCmnU6vC8TTIh4eXHARe1jE89/X3QH0RNJ0P/sbSR+Jl3OufnddrXsHEemhBXCBlASXTyTnc2kybV4sSLTMiJBfv34CEfKTtqL8ApgOZJV5yxyF+42CJkXBC9kAPACQyR2mI05p4mJkfGwOdL7tFkBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296344; c=relaxed/simple;
	bh=x5VReaSgL50sBF3KIP+dylX/4QkKNFX40+tPE9ngFi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=stMEy/XDIA3z+3JhbWo9cNIFcpzUa8v+uR6ylEi0Wg6SQT8Iydx/5lixYg2Syllak4TpRYUei4bGdcZbthpOPMr8lwpmJ6mYGmZzRWhMDGKGE/HBgCtQEGHeyFNQZPEqots8zjhpRkCp1RweZ8UHVva+PAFXTYry3xuq6eD4VU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WaiPV4HE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WwUBERFY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KF8Rqm748732
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 16:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QP3qqhRX1+ugS4wszXTSoaDwa6KVjfZp9av5crBKnTw=; b=WaiPV4HEtROTXZ6W
	VORklX7BAmWkEdNhuSA/7jedUSZmrjDrUD6gziUSc5Y900MU79YQNd01VJzlNsho
	gi/Lz1I5l4joH5t14S3C64k7+1hH7Wq6tINAJQVVBTPHFNW+V7WGTXy5pZxZ7AsK
	N1VvYwP0Ub0eksQNS9l9w/Xntpx31ML+wJpAYo2ZsQL46GugNGGmY05UwLb6qGvm
	GWD96yg3TM0ANgwLvxHUSxu85S3lZWSkBsjG58bjMpqzHFlb/3PEV88SenIqw1di
	EuD3KdQ+24f4iVCduBOYHU2NV0BNqOmFPhRZipfVSn4nMz928SUYlJ55z6Rh1XKe
	o+tmng==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6ggxy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 16:59:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2efc342ef15so6594504eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779296342; x=1779901142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP3qqhRX1+ugS4wszXTSoaDwa6KVjfZp9av5crBKnTw=;
        b=WwUBERFYcilHDjX4uXBVJb5yhEzejubnsJFkdqLEaWSi4itqlwQUOFyLGrlKLg+bLT
         TDdt2RzUu6ipihAsN3H9L92uQPfJRpG/HVDpwifAee7puiIoIVcyyAxrv3N6Y9Ek6iMq
         aqnyGm3pmVbX59leueddY1M9tpOZ1d2WlIpUJ1j0gqymXytigxWTZ+YRIbpP2WUQA9zC
         A+OeldcNfFXnqFtoFHtZX1SQj4esLvGt5o+We2cGulk7EAnT4LiXPeaEtsw+a2+1AvmD
         afcTwv3/BoPahyQsJoieBechLDbicGIeTOiTzbAG4Sh05cCm9iPfZECvWAVQkRVELG5h
         CYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296342; x=1779901142;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QP3qqhRX1+ugS4wszXTSoaDwa6KVjfZp9av5crBKnTw=;
        b=RTRFO2eZ9B1qSK4LMWdjDIL6ALRNYH3W1fA3V5kL2zGvSxG/Vltj3EsxdZ1i7TKnNt
         4FjKTJ/bbY1z6QFgMvyrAN6CX3Qm7tbZDJgDcNohgfQscQWhCgSo3lerI5PrRwPoOGMl
         GJHgrSXwBlzlsoXpKEiZv3iAExxoTmmOH8W8wg7gZO2UEMUAC02r+m8QKZ1alQjXF3O/
         VO2VqRyD/pmORVrNVpC3IPidqoUnluKzp56KbN5T7NcPzpXl8nVi5l5zn1luntgaNxVH
         coRGRdLGhzSCYSvlLHN9KY6aW+i54S18RmnrFOlyuJq1EC8tytthnF5u8m0/Pz/7E43z
         4uJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ym5bhmrGemt5S9+pTT2rI61i+wCjI4TBG+H16Fq+d23uvDWaL1LcAwO2ze8EnFRyxI/YUlFAtQtzq2zjsSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZoHoaP8s2aypHg9nGyDkBMN50cIRB3RNZd28e6z03MlcM58xQ
	AlhqtrxIxxlJQFuR+xTslQvqjITf6EGNVPn1ylTOUcoOYM40DN0i6UR5Z8KPQw6Q2+M1WdTxyiZ
	ZNZazzCeIdpwdbHpLQb0TP45kpzvpI92QDu7VMWkkEkOnia7gFNFVJVGP3jgbzpB/galK3w==
X-Gm-Gg: Acq92OFoPEaomiGyhm6y8d26dqaBHeyYuuAydy5lo4MVcWmgWDE3JQara68+533RQj2
	XHM8OTuIO3BY+i0j3DNO1ngvKpB5kAb3MnTcdNfGxBHgIWCl3pEGe1wx/tAVy60Xfk/vHX6kox5
	lFXxCVor5Jhd50lcSTB8hxI5Rq274gYV/dySXP+L497ie47vHTfnt9wqhTZW+JSpyvIehL+c7lM
	AquH8qYXJjFMS2O25fMlbP9IMF3ZQIKlKiuxcCfrnoxtJxIjj/FJN0W3hyFOTEJeuL4ulNSeSRi
	B5q7NiiV+EbVJZTefx076Nitxc7VIJ/hvNwX1JYbL2RTA9PeXluxf2wMFW7bkck+xEDVbfqbumO
	01e1RQHp15oZ4O8mXfCJp4qLNgWGNZx79/YG7LfoKVCLbRAPj/GhZtsEDzWXyF3Vd9Z+i6yz5T3
	Df
X-Received: by 2002:a05:7301:1001:b0:2d2:129a:1694 with SMTP id 5a478bee46e88-3039868ca59mr11063280eec.18.1779296341834;
        Wed, 20 May 2026 09:59:01 -0700 (PDT)
X-Received: by 2002:a05:7301:1001:b0:2d2:129a:1694 with SMTP id 5a478bee46e88-3039868ca59mr11063252eec.18.1779296341276;
        Wed, 20 May 2026 09:59:01 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978afdd3sm19371442eec.29.2026.05.20.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:59:00 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
        ratnadiraw@smu.edu.sg
In-Reply-To: <20260321110011.8556-1-kexinsun@smail.nju.edu.cn>
References: <20260321110011.8556-1-kexinsun@smail.nju.edu.cn>
Subject: Re: [PATCH] wifi: ath10k: update outdated comment for renamed
 ieee80211_tx_status()
Message-Id: <177929633992.2491273.4266077586938597005.b4-ty@oss.qualcomm.com>
Date: Wed, 20 May 2026 09:58:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0de856 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=E0N25sYAu2rxJyge_XQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: ba8j_xvRn1rz3nnIFV7DetGy0ETWSBOC
X-Proofpoint-GUID: ba8j_xvRn1rz3nnIFV7DetGy0ETWSBOC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE2NCBTYWx0ZWRfXzqQXeHwSkOdh
 6YySAvy3OPOGOyMVF1X1irnARPMcLM2tcgWYcMv89fqmqrEHcpaOZ4P1daqV913+vZ30U2BKwu6
 Z2GxF3yAu3bYH4Y3UOndYizZd22rdwN7TLRaybUl2onMcj8kPWJxUHndkIEzwofvIoxJPTbtKSi
 y+c0KHVLd1JpVsc9FzzRsw+ETHrep9UTL43necVFi7bcJeEOeG8gVaNZvTimT2OsBu+0yA7jLU+
 8i4uwIzy5YEYCTcXZMKnlBjLcCET6eX6YK9w7CwAqE75UtHx8t5UCg4r4Z+4ZV2ZzbBEeyo3+pi
 3AwTSBQBaAlFvEtMgVD3oWW5Ko4RTQNMgHPELCJYsOpj+2bZyt6H21nWBFaNdYG8H7y6M2TBmD6
 PZeBHeMuMKQ8JTtqPO/QczZlopj2sg+hpLMwnaJPLBI8wktkhFBNAU31sE12BEO7cUpWCLzaEcU
 8k1qXGzOGuGUZqKi4dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200164
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36718-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2967159927E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, 21 Mar 2026 19:00:11 +0800, Kexin Sun wrote:
> The function ieee80211_tx_status() was renamed to
> ieee80211_tx_status_skb() by commit 2703bc851399
> ("wifi: mac80211: rename ieee80211_tx_status() to
> ieee80211_tx_status_skb()").  Update the stale reference
> in ath10k_htt_tx_hl().
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: update outdated comment for renamed ieee80211_tx_status()
      commit: 30d516006fa1f72f957c18c6171f5680dcdebfb0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


