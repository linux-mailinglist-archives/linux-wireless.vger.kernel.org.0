Return-Path: <linux-wireless+bounces-36036-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLuSMmqF+2n4cAMAu9opvQ
	(envelope-from <linux-wireless+bounces-36036-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 20:16:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD634DF34D
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 20:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D71AA30260DF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B32413242;
	Wed,  6 May 2026 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+LnISAH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BjhW9i0e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058D3ED11C
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091345; cv=none; b=FZYN5PEXjUlELbxO51kAQMvRbFyxeh+4TWBjU0Mu8JWlU7lOyW7JYEYb0uKEvH6k9Vhftgwaeh+btGwm+OsmilY8FK71dvI1Y66lG6R93wwv07y06rzx8v0Hf0gLhWYoTmV4CTsp/xsYiIEJ8kLUuIKagpZFSqC4Oy0BbrPY5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091345; c=relaxed/simple;
	bh=My/AYEObrJE5fSpZpmNoA/u0sc1GzzygfaF/nwTB+y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+IeMSSjogxnwbNKB4jEUZaTo2IWPemkQ1nXpBhMoEBjq5qp+fCQ1gLM65Vezun9lhaHIsSrC8dHGGPoXNSVUjxrX7M9g1+bb7H+YLo+LmAx1KNfluyojfz3HrG70AXcVyXoDH+SrJgQssYzUXG+RcRiCDN+jlvYp5cGifljIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+LnISAH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BjhW9i0e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646H0hkE1953138
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 18:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3d0biiG3TIvvQzZPN8hzadHrMhW3yVGb7k8u9j8L7pc=; b=J+LnISAHcAVjdHYU
	BmSofpg/APNlQpqrY/n09ZNV61mhGzGKDGlc9Rh8MTSuyEWHf8aTRcSifzJPIBIq
	0PtHGR9w8MhUgB1aL7MseuUr315L/ICSRlm0p9Zwk0yNRWiRG/wsEpgSoBtu4vYR
	KCryRgrCgHMJfzHHjkq1WvCA3p+iX6cASoKcXq6SzzpXXSpTdZI9C0hEGiIKFUNf
	xrv7RvN7tvJRx6ZAl5mnUidZiI7xpz2M4z3yx97/EOyS36bVk52mFgHbYSswXdnL
	YYF1e68uWE83bfmhxpynBLlgFDTNWpcLdI5chlz0WSNip6jldIycNWsiCB/JE2T3
	FlI9xw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jc1uxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 18:15:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b9b8137828so308925ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778091342; x=1778696142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3d0biiG3TIvvQzZPN8hzadHrMhW3yVGb7k8u9j8L7pc=;
        b=BjhW9i0eWsfchEG/M/j2VJkIzWwlMJhP4t5qhjY6I0Of41URlK2c6cC5ZEfs9Xcl3J
         0dIPxPsfHMt2ZcDfLXkmcfkbQEfXucx39WomHKk9XRU9i/iHvEoNt4UZlTyUix+QZQ7V
         +rnhRkgINEyWvNZxHkFDllUiH29i8QzKNO4rrQ6t1ivtgIiCCKBIVPzwIo6JXMU6sDCE
         xpCBmrrA0vy54e+lriQ3a+4z1HemWQXNtgrqETS+qig1vrJGiaWKLHYySdOtCnwkeCno
         BnY5jridBKlIV0uD1ZkBYRbjUoJEWlGkMvP+UI/NK+PaTkWdvPIxK4NXbG5U16+48YCg
         io/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091342; x=1778696142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3d0biiG3TIvvQzZPN8hzadHrMhW3yVGb7k8u9j8L7pc=;
        b=WONYcphf6ZLYtuzHznwhu35Yd1tU12MLBESZcbaR76dwPwc5iTV2/c2qVgjHijIaZl
         YkJItyolEELZKby9lNqm5kaBGTIOH+NqOdT75DF+Bff8Rq7D48z+tDilfn0KOZQU9s6B
         7zpGoF833ZBV65gB0hwXZ0fzNp0BZknVTM3zjUrURWm8TUQN29vPS2zCkJFSAUL4Bww7
         E8kaCEf11sI1vppi79eKJvUdqWtco7/xJcPy8LJo3ZLozDjbQzSFcpKjsztaTnzoo6Fx
         N5HBsxnJ0hwFo2f7LIiIzg3HKUkN04VpHUEqBACuZbdZeIMEgbpxSNnTxsJSbV2ocrLp
         xrag==
X-Gm-Message-State: AOJu0YytlE6mosRv2t7K6zUos+upVwTDDgIMxAnEvDT/QIubWoBz+6CJ
	jRsCdbaTcoSsA14HjDa3K2rUT1qLxVTNbTrn4VL4vlEzRPmVf63jsUw1ohWIu6vOiRe3BbYGzPh
	RYtLyXFyA7NXYx13hopoKyPlArdBXQU0kKADTtUl8VWlxNt7yQwwfdz80oYa87Z2qRhGlDRBoEn
	LBqw==
X-Gm-Gg: AeBDiev+GYjKWr1K+ocQexMgZM6fq9SetNYAJj8npYOZEajq9aRL75Vx68EPDp3HtuK
	Xb0fVhbzUTslaWqLS1mcJX2FgEiDhvmYP0EZSrZELt5q2JRLWN94wmxfmzKirli4DbG3rBcoMZj
	8Vvti+oo365zXB3Lw+HXAN8p3C8Dqz4iQ7/32gJECGIwXfsOFuJntmmbje+Mcc5raCSx+6Cn23c
	gFPmL8UrKnOGtsVl9KKacERTD7ivgwrko/AsTXiLbRd416Lin29Z+CSlLxgN8Ndh3pTMQWtF+nA
	jxhQlBFDs2oMVmd3mOoxJCj7vLJuVavKphjAEBnfb/51sZL8KziHBD8aH1/GM+xh1gqtX0uwfLx
	YqOjrpEs51XjNL4iW7e9A50j7M73qDs9uaX9smVTqmBFKnG7XZCyNtZNtD8UbWxfrQxmYrtQ0JD
	aX4SMBlDlhFBg=
X-Received: by 2002:a17:903:2687:b0:2ba:7181:7058 with SMTP id d9443c01a7336-2ba78b3fcf2mr31631915ad.7.1778091342133;
        Wed, 06 May 2026 11:15:42 -0700 (PDT)
X-Received: by 2002:a17:903:2687:b0:2ba:7181:7058 with SMTP id d9443c01a7336-2ba78b3fcf2mr31631685ad.7.1778091341577;
        Wed, 06 May 2026 11:15:41 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e181fsm32986135ad.47.2026.05.06.11.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 11:15:41 -0700 (PDT)
Message-ID: <7559c6f7-1957-45d9-b1af-b319e531dda7@oss.qualcomm.com>
Date: Wed, 6 May 2026 23:45:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] wifi: ath11k: fix error path leak in
 ath11k_tm_cmd_wmi_ftm()
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260506134240.2284016-1-nico.escande@gmail.com>
 <20260506134240.2284016-4-nico.escande@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260506134240.2284016-4-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3OSBTYWx0ZWRfXwGk/pgToqLnZ
 k1franpCB65dzrSM6F4tnFpaF0+huCQ6bevXQb6xu9K0UDa7l7xSBGYnAzX3ZVkIYvxGVpYewX7
 1jzPTlf3JDBQ+Kk0vnDQxmN9zImmN+PMhuPuiNUH8UrBZFokCDa/SWqMSPo0FLFKVzrUuid8Use
 X7WfVO97rNh7W25GWEnLLfkSNw632k9WOEt/37v77KDZo62rJ3j69aryGl995ttkUw9rXKVRcMW
 bLvZC1YOvnVV7B/4+LmuSMlJu3RoDPB+weCmIOzkCAFojBiK0vzVHDd0H2RwHWGFZ1c4mW0nF8i
 VqAl0cYyNzYZShhP6c7FnCNiyBJN/Ur56K7pRfoEGOM/peIA5YTF3pC5/2EAS1EnXLCszeUsn8L
 yeYEehIU+ZZkI1/8jmIXDgRe+xfTtZyoqjaW+2lPd98q5aNa1hDUPWc/Gk7OTFnGYfqyBCKdiXy
 OXJcBKV60SJCRULiwIw==
X-Proofpoint-ORIG-GUID: q_PUY5v2wl90QtO-jU3MsyG4kaVoynSl
X-Proofpoint-GUID: q_PUY5v2wl90QtO-jU3MsyG4kaVoynSl
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69fb854f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=YLgCGi9CYVZ20EZikPwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060179
X-Rspamd-Queue-Id: 1FD634DF34D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36036-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/6/2026 7:12 PM, Nicolas Escande wrote:
> This is similar to what was fixed by previous patches. We have a to

s/We have a to ../We have a call to .. ?

But no need to resend for this, I think Jeff can fix in pending ?

> ath11k_wmi_cmd_send() which does check the return value, but forgot to
> free the related skb.
> 
> Fixes: b43310e44edc ("wifi: ath11k: factory test mode support")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/testmode.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
> index a9751ea2a0b7..c72eed358f6d 100644
> --- a/drivers/net/wireless/ath/ath11k/testmode.c
> +++ b/drivers/net/wireless/ath/ath11k/testmode.c
> @@ -457,6 +457,7 @@ static int ath11k_tm_cmd_wmi_ftm(struct ath11k *ar, struct nlattr *tb[])
>   		ret = ath11k_wmi_cmd_send(wmi, skb, cmd_id);
>   		if (ret) {
>   			ath11k_warn(ar->ab, "failed to send wmi ftm command: %d\n", ret);
> +			dev_kfree_skb(skb);
>   			goto out;
>   		}
>   


--
Ramesh

