Return-Path: <linux-wireless+bounces-38531-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DlizBvLTRmoeeQsAu9opvQ
	(envelope-from <linux-wireless+bounces-38531-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 23:11:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583826FCE06
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 23:11:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hfOhZcSs;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Jw3l52T2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38531-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38531-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5761030722CF
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 21:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB94359A66;
	Thu,  2 Jul 2026 21:06:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB933F5B3
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 21:06:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026403; cv=none; b=PoF74MkV8iCbAN1XLwVM8Ggx2aNv66RWHoaY6anW95ZikMyxJy0CousfCD4oG7rwfzCUk5s6Xh9FA5viFb31M/vmXhPqZm5rPbf29gDS5C1OF2UXWLrFje3L5n47oU7PppbxZkFvKSW348Ja7XqIPbW9eqO82Uv50h6rGMC2iFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026403; c=relaxed/simple;
	bh=dH+CKXyME6aDU20HrXr6nxftkT+Bm7QeUvs9ocYmto8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EvjRx4hlxF7r9SJbF2bg1zzFDxCBIcd6ngvjYO1znuIuE8ELwiZxwsVbBgLQ5Nksdg9r7Tx9T75/s263qxoItSrvj9te0+PqPHVSReURZtQIXYio2KLzQ75OPfcAjj4W+1PblYTsL14Y8lVgJ5la1LbUgVB17SjaocrzeV2JdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfOhZcSs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jw3l52T2; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662Iux5h1381368
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 21:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mcKsepWyNI3nbT5QEY3VlLdyd7IHG/djO0xrjG5CLZA=; b=hfOhZcSst4CozBRV
	T7NdwbRbWXwTM/HKvyjUA5149Suz8puIe9JlRT7hPKp0ZKYrTVm4LSZKBL/qt8Hz
	teROrXeKcIoxA9SXZy0WBxh5nBQsvPpLVhqIwgki+gqp9LteVuTpSxAaSe86oiYq
	YyJnvR6Fo+a30EdY30Ka0OgOXgBpYzmJw2UuIS4mgeZi4RoRHeMvE+by5seoTMV4
	HZg2XqqKBDdJKyf55UFIStlYocEwkmY5V3WTKD83sBrgYeaieX033YQZbcEL8rM2
	SGM2dAEUDRyxKsB9HWcnuyG4NXVZYO23WzPF1KXMpCQLl5+2ZwioyZsDJWyFfrZX
	RMdnjA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc38pg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 21:06:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3811279d51aso661547a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783026400; x=1783631200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcKsepWyNI3nbT5QEY3VlLdyd7IHG/djO0xrjG5CLZA=;
        b=Jw3l52T2XWNlrvGZKpVfepS9O8jXwMN/67RA0I6r3wV4wayNwdSWual/a4c0fHUNzq
         eLkbuhFjxIcrv+yZrV/ucq8VQwUCyV36HQ2l6VwnqbtVA4aB1OsUwxHu2VTMJdm87TGl
         PVema907+NARt1JIn/z2yK93aZ1OwSD1/xn1fDNOGpcTAtsaWUpb1rTjaNwgDylmUVnI
         PKsQLhnr0OBdDtb6dcleVoX1XTtaRTjTjpeIJPHyk4so4YvJ7af75U9yQnddzmcbqQTz
         lhPNTpomL9jLVwVWIbyCNzvPWv75hjR+jAMBCEXzyp1MNQlnMfIDqoXVck01gUF4ik00
         hgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026400; x=1783631200;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcKsepWyNI3nbT5QEY3VlLdyd7IHG/djO0xrjG5CLZA=;
        b=kYuyJWYRPglnphYnLOdangc/d6HgPPgv7UuRzM+mcqPK9dy/or1419jSwMWPKgsgln
         WA0yikrqWyu4S3bnnJIZg5NglrLvlqRXjf5eXj/3s1tXHOnfIEoKJJVa+j1UkmSnDAP/
         k6GW1D6mH1alH/aGZG4fFt4pAkxITvTJsj8PkLMjRq1PnbvNToqPwPVtGI5BQoCEDbgl
         gt1k924wAo0Hjp/E1HIOom3Gq6+S2Ba9MytKSgp9AOq/EuJ9ly/BxCkHsjcDqVyhdW7t
         21UibOFgjMlRs9LI1Mfiz3zbduNy2IRCHXfX4cLtSFVS6C8Zg4nghAf15wFtMqAIknia
         u7yw==
X-Gm-Message-State: AOJu0YxQCQdCQo/yb4htnKU0980KnL7LNIvHRhDN8PCuy9l/fudorfEq
	n7l9WyqTuTF3vdG4go1JYut7Gavwu1M408tTzvloc93FEc2MuAE3exwH8YDDfOhTueRuvRUqAjO
	wxDxPCjieEX4ILmbomcTN/jahNKXxGZqcs95sDcVscAqF0JpLOtv66Ex+j8SaZa1gEHauqQ==
X-Gm-Gg: AfdE7ckwSTHouux+EJz5Vg1eJyvh4TREFV+eE+h8iQ/1O5VlN7XS/ftWfwnJQXDXdIJ
	AFYZJCw8qnjkUtS8E/59pmp+bp0aXjVk73jfehdDxOFPgbVFfWB5oXyv1dQfLHsP/KvjCZsiLYH
	CTFyo1YJ5K5fCpNdupl/4lYMOHd2nSV8yjLSlUMvAOyg4z/z2UnitUF1OogwMAux18R2vjs27mb
	pAVw/m5+ocb37DnCPCMLpaEv1B2QUhrMShsFY31P8V57c3xrlGPhNCKHlJLYOFnrTTNe4CPQ2EK
	eNUvHMCebKQP3qJ+0i2YWMtmYFk9huF06X4fQaS5odPBx3a62lEKGeeia9HmTnieCha0/a9DS+v
	AG3TFkyyY+6FJoInUPbcW7s++C6YhIE7M3EM2FWM2rnp8cVkHm14VPLCgGeLur3c6xg==
X-Received: by 2002:a17:90b:54cb:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38121c17f88mr409719a91.15.1783026400388;
        Thu, 02 Jul 2026 14:06:40 -0700 (PDT)
X-Received: by 2002:a17:90b:54cb:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38121c17f88mr409660a91.15.1783026399822;
        Thu, 02 Jul 2026 14:06:39 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7bb8fasm12300233eec.1.2026.07.02.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 14:06:35 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Daniel Hodges <git@danielhodges.dev>
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, kvalo@qca.qualcomm.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260206185207.30098-1-git@danielhodges.dev>
References: <20260206185207.30098-1-git@danielhodges.dev>
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
Message-Id: <178302639490.4076904.10429131082562812583.b4-ty@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 14:06:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: -IDX3TqFzPXtAfNKJczSp3tfPPkq-BVg
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a46d2e1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=tfyPAs_2uK2ulwPNWpMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIyMCBTYWx0ZWRfX4X+RC94H8j33
 /W27PR4qeJoUQWcf6yrokaMkI6kebtg+yJqm7wvZWylMWOFs0T/077F5kMhh1G48IrggR7kaine
 ITVzR596K/uUJQLnS7opPl53FRVMQLMcaaPNKbxm+L/t6TglbvmX0Uz+WFJoXyn5JGNu5BUAI7C
 MrrfJvP0WamDNXwA6htsfMd6UYsBIiYi49ytXCgtnmT+6ryn8bYpLxjc2PGMfz6JKCPO+56E9Pm
 LBuJ7GDfdrXb7SUbs2IxqTMfjWJGTdmiG4DqL86s74a3UBl8LoGROW2iwQ0AtNw2MYxHnpy9ZNX
 RR2UUda4vWUGPvVewUZu4gNfXOCqSANNN08zqxRzPfkTEL/imWrv3XtbPfu/EOzHq6eLZFQFDqH
 Fnyf8JnsXqvQWyBJjM+J2bBcb0KokofzI/Tvm3moC123lvUElvCGHpyMCn5YMyWfpRBQbcfvfoN
 K+96sVT1XUyiXBtu17g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIyMCBTYWx0ZWRfX6gL4C/EI/WfI
 C0l/Xa+WeiPXWirx5Id+dUzytSUQZ8rZvit8+Z7HnjQwy3vlE4AZU7y1mmJQZ1bmx/brn9LjsNh
 i3CHJ/FkoDFsaiOzwL9xpQuGwogYvaY=
X-Proofpoint-GUID: -IDX3TqFzPXtAfNKJczSp3tfPPkq-BVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020220
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38531-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:git@danielhodges.dev,m:tglx@kernel.org,m:mingo@kernel.org,m:joe@perches.com,m:vthiagar@qca.qualcomm.com,m:rmani@qca.qualcomm.com,m:jouni@qca.qualcomm.com,m:kvalo@qca.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 583826FCE06


On Fri, 06 Feb 2026 13:52:07 -0500, Daniel Hodges wrote:
> The aggr_reset_state() function uses timer_delete() (non-synchronous)
> for the aggregation timer before proceeding to delete TID state and
> before the structure is freed by callers like aggr_module_destroy().
> 
> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
> is called, the callback will continue to access aggr_conn fields like
> rx_tid[] and stat[] which may be freed immediately after by
> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
> 
> [...]

Applied, thanks!

[1/1] wifi: ath6kl: fix use-after-free in aggr_reset_state()
      commit: ba7debb4dd6427386862220e8335a53a4bfc235d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


