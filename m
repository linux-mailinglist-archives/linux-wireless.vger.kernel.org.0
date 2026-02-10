Return-Path: <linux-wireless+bounces-31693-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJTYCh8Ki2kdPQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31693-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:36:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF17119AF2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA0073007ACE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BAE3161BA;
	Tue, 10 Feb 2026 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QvUxNJfb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a5ewytCM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDD3164A5
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719770; cv=none; b=Wpup+dSd9zompLZsdChuHySY3i9AxeP1rWhUyIAf0eYLIChbQ8RA71/Yu+ajTP1wVF6T+ZU0Xhi0/Y2uDyySJoYjaBy9xtW3DePL+9x5n54dfixUAJMBZ2JWzAVLbo4NP6AjvySuT/5sRBXwscjztvTQ5QmBBZD60EEFJkN4sZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719770; c=relaxed/simple;
	bh=OSV5gOv9nIfS563488CCNKOcF/iL8QNjxDi4uYqUgxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAUW3kuoApOO16ovHqnhT2XcI29rJ5qmISHbwKbQGpcEoF9/jULNN1g47xYo5daCgt/w0Oq4z8SSYxWMjXxadQTXupcyuHkwhJescG5qyFscl3NfeY+/l2T7PsyVnQwQPGh2r8iJalPTp4c/TifGyw+mjMY3sXKUrenirA0lQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QvUxNJfb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a5ewytCM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A9ugL01172090
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GeGd+0ukxLqJZ+xiY3Jn8xyCU7ENjto6tOd/HY54jI0=; b=QvUxNJfbxyoT0310
	PH22QEhAOl+Xk3RaV10vF9v+W4cp37JO3Y5ohYyraOboh6H+53KGaA390dpuYJCZ
	TqbFtOejBoNaF24EuprJyGa/kKypR0yY2wqvWS4tk+QwPgCi32FHl9DhfFelMmCA
	swm+z2JrcojoNNq8y+szM1LBdUNi+Obsh23+obzUxU5jMyhxeUNI+c7xWwFQDfmN
	jjeSprj+rh8H/ECXnzES2rPun0gr6HBgUj6HIF43iTvxf8Dj4s1xk0fh5z+uO49k
	wqcyV2JanUgw5ru/qtxm9nnb5MMz+/dQ1M1GN3+wt7THEOTM1Jz4ALccltzTYCBY
	1luu+w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7kftu6kd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:36:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c551e6fe4b4so3855801a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770719767; x=1771324567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeGd+0ukxLqJZ+xiY3Jn8xyCU7ENjto6tOd/HY54jI0=;
        b=a5ewytCM7XRx/SdB1EuD6M/J3lv/F/lVOU24zhJfCa54exEBylb3n8nSqwwRi/+mqO
         DtPDMwdOx61UYPWVLMOVzblffr3qj1o2OJkNJnupaVj33og+wcIWGBdGpxyXS+aktTqH
         nmrW3m50cQ1vo4bVJFcP3+4RpZA5P9qOxOTw2pjh+U6BANWd+PyOYahBjXfs5JYVKCve
         hUzATNZgrVYKXaIEJGVW+BJ1cUSvL9+oX/pwPksRystEL0m97hJjqjS+jRs1ZbK7Ip+W
         KKr9Kl3KCF+HaoN4sK3fQpg3wPRtZMZbmQGPRF83cu/JCk37TS952hhY1YbauVMQnWiJ
         yAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770719767; x=1771324567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeGd+0ukxLqJZ+xiY3Jn8xyCU7ENjto6tOd/HY54jI0=;
        b=h4LpMY1ZdIrqDgWwAaB3tyngguSNdGqOViiREUnXLzZOA8AKRbDjPjKJCAD0VJLGhL
         VjR63v4Hc5EZsqwbmLNgYwrenUx3SSM4RkCx3HvigtqZG8lEBSkOe2WFzB5shp6OaBKL
         MygkadUbKS7oenmYWHNNhSdLel7PZDcvGo5iAnP1PxE19CDydJYzrhvHB5+Ubd9ltWae
         oRetxnvm9JrxQN/A7M7GAJrwoo8rSYlmOHpsanEtMjzWHttAzrbcylmV2DbW3HCO04aT
         14A87ktHMAj+ixxCZe5wuHIZgwjFbewiHZHpR4XmQfcZ+mRJ1IGMAZg/yFKjfqhAvhQE
         eEPA==
X-Gm-Message-State: AOJu0Yzi3rkUtUL1fLvciTUB7MNi79OZqbde+z7lgsyFZybHw2qbCWzm
	8UAHu4KzKl6eeoC0DuBdrE3woEXPra86vrCUl4WFTgDzeMgnUj2XHQT4q5LshkJSNMQ7Hz6ZOns
	tJyUcOo9Kcs8c56BYMjZ5Q412gULJHDrbGaescbEANd1cPrAUISzh7l3PiLXXB8V5KLzqzw==
X-Gm-Gg: AZuq6aL18+TGwD14ruhn8P563McAk8YlNgIYQHW07keK+Bo4WaL3U20LHmMw4QvDEDs
	6PUAHmuH8cK6ZPdxSoei74gUfVZvtjA/eyBmDIuaJg77ad4CLA31lVCDx1TkLJ8fexmPH6RUIY5
	GfmFH9ckg2tG8yYqzwgUvysI0xZmAVkAOX3tROdGSD5ZVGMqYX/iUEYfiP4Tt5ynmRhIjzHJs0b
	89ZltRZMImq549vI6ULk+Bedn5f6XJXxkLcklRdcr9NN80PQsTuPfNOkRh8j1TCV0faLA9rkTvH
	ZTYRBPmnwnYDTmjWK03UQ8qSUvjZ42p2NjMsXtlw1LikRR9xL0hyA96V3xwT1AO2jqReLC/bh3k
	ggDurE1opYmTIWCGXFKAlt1ONmBSUWbTY5kMvfnHi1D8I8GzaGiV7z+Pdc1tJCEeinQ+q3rCB9w
	ncVGUAyJASfwBvQrXWZbPT4PrfLTWUYaaT
X-Received: by 2002:a05:6a20:1609:b0:35d:b5a1:a61d with SMTP id adf61e73a8af0-39417bfa008mr1842855637.26.1770719767412;
        Tue, 10 Feb 2026 02:36:07 -0800 (PST)
X-Received: by 2002:a05:6a20:1609:b0:35d:b5a1:a61d with SMTP id adf61e73a8af0-39417bfa008mr1842827637.26.1770719766893;
        Tue, 10 Feb 2026 02:36:06 -0800 (PST)
Received: from [10.79.196.209] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a952221b4csm140967055ad.89.2026.02.10.02.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 02:36:06 -0800 (PST)
Message-ID: <307b4098-8154-4d83-993d-88efe38426df@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 16:06:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 3/3] wifi: mac80211_hwsim: add incumbent
 signal interference detection support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20260205112146.3997044-1-amith.a@oss.qualcomm.com>
 <20260205112146.3997044-4-amith.a@oss.qualcomm.com>
 <858522d4e40ec73197bda6a9753b2eac8c07d145.camel@sipsolutions.net>
Content-Language: en-US
From: Amith A <amith.a@oss.qualcomm.com>
In-Reply-To: <858522d4e40ec73197bda6a9753b2eac8c07d145.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4OSBTYWx0ZWRfX2aQO3cJXdqyd
 SsijpjVLQtv0sNz6FBVK0xxsuymStYAbE5HRGSmePtS5dtiZsylhUjppec3RnNh8epnqEgz6Bkg
 gmesBI3GIrFETglpbd+NF/oL68ZaEXFwCAMRYuA2Jk+hxm0q7dvhzlzmYMzqz3LLz5zgcQyEt6N
 K6NDip53KyY8JmqvNHc0Velu3eUeN4/9Qdq20P7VT3Pdo4THJ9zeINMUGYufkAIVwuIvE5Epyez
 HhBsfZMHU60z5LgotDV0izcTso7aOJrBJbnqTSerhdgoP5p6yyxHW/29mREvhKImGZW5/AOpStp
 CgRpQ/Ca/3h13nDX0bFmvr2VwOT5fJbhESVoVtR5etMK1ZiE/xbFt05JvbKfAxis/rDjk4BEFgC
 d6YTHBCCkWjBYI2z3TOlaQ5gOszoWxSeeyesu923AaY5bMMcY3VvsMd7+r3x4iygPSNRGDc0Tp8
 YVwOoRve5M263EAjcCA==
X-Proofpoint-ORIG-GUID: xfZvakm55qOAnNzOPtxSJP7VMMPc8aYJ
X-Authority-Analysis: v=2.4 cv=XfuEDY55 c=1 sm=1 tr=0 ts=698b0a18 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EKQS7nNsnrzVfLVtBBUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: xfZvakm55qOAnNzOPtxSJP7VMMPc8aYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31693-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4BF17119AF2
X-Rspamd-Action: no action



On 2/5/2026 5:54 PM, Johannes Berg wrote:
> On Thu, 2026-02-05 at 16:51 +0530, Amith A wrote:
>> +static void hwsim_6ghz_chanctx_iter(struct ieee80211_hw *hw,
>> +				    struct ieee80211_chanctx_conf *conf,
>> +				    void *data)
>> +{
>> +	struct ieee80211_chanctx_conf **out = data;
>> +
>> +	if (conf->def.chan && conf->def.chan->band == NL80211_BAND_6GHZ)
>> +		*out = conf;
>> +}
>> +
>> +static int hwsim_write_simulate_incumbent_signal(void *dat, u64 val)
>> +{
>> +	struct mac80211_hwsim_data *data = dat;
>> +	struct ieee80211_chanctx_conf *chanctx_conf = NULL;
>> +
>> +	ieee80211_iter_chan_contexts_atomic(data->hw,
>> +					    hwsim_6ghz_chanctx_iter,
>> +					    &chanctx_conf);
>> +
>> +	if (!chanctx_conf)
>> +		return -EINVAL;
> Wouldn't it make more sense require userspace to write also the
> frequency, rather than randomly picking the first 6 GHz chandef?
Agree. I’m currently using DEFINE_DEBUGFS_ATTRIBUTE, which only supports
a single u64 write. To accept both frequency and bitmap, is it okay if
define a custom fops with a .write that parses two arguments?
>
>> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
>> @@ -343,4 +343,6 @@ enum hwsim_rate_info_attributes {
>>  	HWSIM_RATE_INFO_ATTR_MAX = NUM_HWSIM_RATE_INFO_ATTRS - 1
>>  };
>>  
>> +/* no longer used - previously used for debugfs iterator */
> Hmm?
Will remove this in next version.
>
> johannes


