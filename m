Return-Path: <linux-wireless+bounces-37452-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fqhUNalCJGpS4gEAu9opvQ
	(envelope-from <linux-wireless+bounces-37452-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:54:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EAC64DDD5
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:54:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Q8Fm3ghq;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="Y8/blm1F";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37452-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37452-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45315301FCAF
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 15:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787AA3B47F6;
	Sat,  6 Jun 2026 15:54:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA42F5498
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 15:54:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761244; cv=none; b=S7kroTmmSPUC0qPS+oOMaXPaWkj1zRggXZctpxe8kPvYaOwa35HSigel+YBxnXMyva0MS2DhScBnqPA+0rsEkoSivKA3wSCWH86gM3yrbf1Jty4h9xPNpdmExZv9lvdWNOqEgTRhwXKxKw9nwzT1Apx/Tmm5U96LDCQisAVBs/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761244; c=relaxed/simple;
	bh=zGFgxei5n5dUS7HYBDcD2HYJvN3JliN0KtG8a5KjwgM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RU4d2OBPr1hsLKHsAJvN620oTP4AgsTddqEif9XE9uLqWfctrDsZ5M49wAM2X1C2dIL58rqNwdekFMCx2aDdpJBjL8a6VyHNjqlz/KowcrkJ43GcbQ7dCQrIYNSENh+6DNbcGhltdoAMExxvqu0ngAmzi8NArVFIdxYdenWvGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q8Fm3ghq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y8/blm1F; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656EujTi2122499
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 15:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k1sKfKnsPbOJLSry5oBtMzP/jZy4bw9UAnx03Oa2qmo=; b=Q8Fm3ghqQcCw2AoB
	/luPJDvwYAtX/WYIwMjiXQu3yNIEkq9Rw7pg477eQRWmLbrSVrXiWJNnPVZCGgFD
	oi/SLqdMh5pBAyuF12Oh0izMaA5a7kEtzXQyfSZHTk3/fBQx2bJMBGkmzx4Cu3wx
	c7PxuOzudPmPSCLx0QFz3KnzB88F0P6RNwNY5gWCIhkLUmZnQ3bWQ3IfY57xYIlB
	B2/K8N4Ss5FlVtFIV8eK3Uy3FhzhBJ5ZNcPW9qmB8YqcPLzGAuJZ6AtoP43HnnFr
	d80J1E+R36KEXAKrV8cEgava04KNNeCe60FywXrM8vmBz9ibsRBFtY/oRgMpWJot
	IjZWfQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf1trg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 15:54:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3075fa5a407so1241664eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780761241; x=1781366041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1sKfKnsPbOJLSry5oBtMzP/jZy4bw9UAnx03Oa2qmo=;
        b=Y8/blm1FO7oQt2R/GNIjt6sAON7EqfUgMqeM6qwQ4QiBgvtFRD8eGzbzHTJY5kX1iR
         wIF/qgNUG9vir5P1/eQLihLjf6WixGA9M9CcJtV8Z1QHVJGGRITkkxSfrOIGdobghe4B
         A7Ug0Me4T1/N1WRyoyI/i2XvHePk3GvoZvj9nDWxqpWyyh73O4DK2eiMhkZgo727ZBQy
         MrtrqvWlIdPnu9RWjtxMnKk4LD+46RmTj91pL91fAH0vK9BvAYvujh6xCru+axeP+1wG
         pF4zl4oUfOlNpN1BU0s9mwrY/Lja330JoSw70gXrq5Okrk/vHjRPEjexgt64CWsmRbJ1
         FWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761241; x=1781366041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1sKfKnsPbOJLSry5oBtMzP/jZy4bw9UAnx03Oa2qmo=;
        b=jsWt+KgCs8Wer6uNNfEwsaP1vfVXJxXk3m7W026LMPvcwqk1dxfVijnZow96zEwWEk
         blt3VYCxtEEDf73uLfeur6KsvAXfv+JLs93+HVCO1KaHmItQTGbbptg51F9voaoqehdy
         OYxyRG5vhbe8bv7BeTTkaVwupeCsrb9pzTa6Spl1xDRAk/G9MGZLKIUULq/bjL5dOLK/
         Fgz/9W4nUewXCxdaUhnACbU+f2Zc3RTeXvc71YCZvxPvfToObnB6E1+F0gmFJii+JTNT
         kNy9rkHBPJh/rM0MKBtRHLmZt0DhHisBVVgxQ287v/AA+XfeJjh/yF8eQY1JIZaeME8c
         8T/w==
X-Gm-Message-State: AOJu0Ywly9hPlxgMkH1bNM3n4hctkImJYwnbyowFz+pDv6TCchIXvser
	9MV/aNvKU50Jtq1UTUnXWxsp1FGQ4etPHgJzKb4vO1ifKGmailRkHKorWfjolRGlmU+tTggCBmx
	fyf7mB5sooZcZTPtmeGVKrRXadtwupRP1xvyYstWJKrpKi32Xod/CXZnBgWTW719SIvobTA==
X-Gm-Gg: Acq92OGtbEm0Uaz/5PBU1DiktBm7nW+rSvfgiibR/0/hz7qVyJt9cqSOyRWQQW2f0Ik
	a3gQxQr9QrvpgnNckeR0kDajHnPJAPrhQFYkwVtAA5ilpIOluBG2yMD+YnBlm4GdkBAjEIct6p5
	vO+9cpH+qDwI7cn0PTFNZKgA0tcoWLBd2zqIYHDEmf+OMBsTrFsLip3jlDPsUbCYAeEjEuzuQrh
	/KTDyTo3Ui/oFtu8JnKfcSt35Us+KQSNQWXWuqmyOdU5jzFRs1wOlHZo8LSNSIp/jO5GD1HVQXM
	HtK9xO4CaKtx9/KJtTcl1p2SHdFn200l2he1z2ULYcso+HxxN2m+HzcRmRZJzfoIGrYLXlNbkdB
	M9pHXBDYB8loxHMh9uHh42BrJJxgMvLIVcQM34IQBFy4NC6zNBzEQ8Ido+mkmsNm8z43AuGs3Ev
	Wsz7p3haToxuU=
X-Received: by 2002:a05:7300:4347:b0:304:5bee:f59d with SMTP id 5a478bee46e88-3077b845773mr5122619eec.29.1780761241307;
        Sat, 06 Jun 2026 08:54:01 -0700 (PDT)
X-Received: by 2002:a05:7300:4347:b0:304:5bee:f59d with SMTP id 5a478bee46e88-3077b845773mr5122609eec.29.1780761240766;
        Sat, 06 Jun 2026 08:54:00 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm11240392eec.24.2026.06.06.08.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:54:00 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, wcn36xx@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260519020317.635011-1-rosenp@gmail.com>
References: <20260519020317.635011-1-rosenp@gmail.com>
Subject: Re: [PATCH wireless-next] wifi: wcn36xx: allocate chan_surveys
 with main struct
Message-Id: <178076123996.768205.17179080034691161279.b4-ty@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 08:53:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a24429a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: wzDi8IBI5VNNp5JgWpGR6hVrV92aEHis
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2MyBTYWx0ZWRfX1ATIatYhJozo
 UG8Ohe+aU0PjgAp5Ue1xonK5hWRFi5Pz9/fud8ReTghuvCcnl53DmMaEjM4zvuKZLsN4dk9Qwdi
 fOeJYOIjh2pACkAuwbRNZLpqkxShDkHvh6lgRbyp3SN8wUFG0q988MMzkFqrOuHUmGX79egaBup
 AJbTxHv9w8v5Q/KSDpkEm/rQ4lvc5AbByKZRZynGw4FCqxAcKT/nrFkmQGc5DJm1R4IDOhgkh5G
 /2QLzDFpEsW2UWSswMe3D9QWJ1pPu61Y1XjqKoBIJU1kWIhgqw4gjOC/4Ja/IpotuOrA5+ru/ZZ
 heW0/w6oM/sjCklYVZo1tHCuX1cEgEwc1ws4ZQVGgZMjjagYrNwHzX8z4i1UKIODR7+PFq+xjxw
 /9oKuYA6v9z6K1ba4uijuEWLLKvxBinlilQfwBmcwPSCvizazYP387DIz3zvzq4oUB+uMqdmax1
 jQXWWo93Xd2g+1BiKRA==
X-Proofpoint-GUID: wzDi8IBI5VNNp5JgWpGR6hVrV92aEHis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37452-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:rosenp@gmail.com,m:loic.poulain@oss.qualcomm.com,m:wcn36xx@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55EAC64DDD5


On Mon, 18 May 2026 19:03:17 -0700, Rosen Penev wrote:
> Avoid allocating separately with a flexible array member. Simplifies
> allocation slightly.
> 
> 

Applied, thanks!

[1/1] wifi: wcn36xx: allocate chan_surveys with main struct
      commit: 0bd50e363581a9f833c051f7543ffd1fd3455509

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


