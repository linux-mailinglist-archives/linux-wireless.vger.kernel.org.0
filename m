Return-Path: <linux-wireless+bounces-39100-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SpmxBgh7VmpW6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39100-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A75757BA4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=UytwnRh6;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=OzZWnpW4;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39100-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39100-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24E863043798
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E683CF207;
	Tue, 14 Jul 2026 18:07:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1B3CA4B9
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052473; cv=none; b=TogCK4sy3vPUqX1kFvoC5yyOEer0icycQ7R3a679kpchCwqYeHpDAEiqgJi1dEsi9Rl6/SJBWSZBpSk2Rzt2s0BDtTZATKhuM8lKO3DOEaR5Ziuwkx61ttfwXYGAJoEuSjIIEq/wK5G4FH55PjwSRxhp5Cjc9idFT0D1bTx7PgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052473; c=relaxed/simple;
	bh=zX8o5jSDSZ8QGrnvKEYDJCepjTiZZwGx2V+Rc+oVLvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ubtnQ/ZhBTjHBhTo19lDQJhaBmFzjNoavHuXnUYRFO9jV7L63PTsBHHfQj928dCSuVn3sEkYvG3K5x7ZovvpwW51AJwbLv4UJ3TLQ9BG/gC5oJ6P0GbcnKTXafeyuieZlaGFreDyiU+dAFj7GEQhq4fZvJpnNpwz3KYPNlLjAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UytwnRh6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OzZWnpW4; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG75Zf1091275
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2cKztgpSNjz3WKUCSrKkFj0FRV10LmHOvE5zYzFACW8=; b=UytwnRh6KqgcC0lX
	KVGpRsB9qhja5Pg/BP9NgoFaytz8mPapShHcJlC0SRunomtbZiZpaD4IHreOwo9o
	TX0/eecIZhw3bn/YXX03e4wgmUtBTnoanopd8p7ypsq3nVvGwC4I1FVAUK+5kGe8
	QDZEebQ/R31Om/+TnVNu6vaw5sQqfIa/HM6vsR3jU6t6FEZgVr9fqHkekbK7XQqA
	ZPtNErVYUgcUyekFBlev86QhT//iQuEz9ppHr2mZqmTnlamyDYfFxwKHUHB6G7vV
	4JWYFP0NT3idKhWnscKE12eqlOOud7vW2C9D0WCrFIjpjZB3Lj5bq2FxiuMD0rQF
	3WuzFA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudjgct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e66f9e2baso190605685a.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052469; x=1784657269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2cKztgpSNjz3WKUCSrKkFj0FRV10LmHOvE5zYzFACW8=;
        b=OzZWnpW4qrAe7FjP5WtqThL53GLlAiKOmzeonOh3qNpkgvpRG02/GChQ47rjG70hQU
         8Txw9Het22oRevdnj7SW4k6180IIDkf9vBVxfdZ/A+v7ZW+MW90v1Kp5XM/rcGqJctBc
         Adr6NALEk435xP2BtxpK/B6+PQ3rAIkTbY1tl/4xC/C/K932zx71qiDbSl/MDL+dtPvb
         ntL9mYvZuShdCiiEs2z/fw3QnXh6c2wmJTBb/whuIgxQqXXSBlDKx8mjLPGfuUH+to6V
         SV/FbJZoCd/amV8ZrCEHhDuHb6fNy+voh0L+ZW4R2fZdNOmRMJekJUm6zOcV1V57v4lP
         4kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052469; x=1784657269;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cKztgpSNjz3WKUCSrKkFj0FRV10LmHOvE5zYzFACW8=;
        b=fRD9krbbFKOp2iNtWK3sKyYDnTGN9RjO1Ow2KNQUdCSQ9UNYHpgyo/FZMWo0b3XoEJ
         O4aQUXNLKQUkbH98oWSRFjV1kmC5VDLvynnZXnlbDYNQ9fQZ9GGGXJFkJxT/Web7ApRn
         wOVBkUz/2pzR6Li7Tvnk5+/PPJTH8F5D7k2lO1pJr2XO1Nn1rwlAqNhJVI29i31CZNRD
         sf3L8bhlrrByxLYSNo+LWnqJOGKR2dob8zadO4admOMw5y7hhOluOmDSqNns9714/N5/
         afKUjRKyOxHiF589NOaydiE6gxOrKlsMrN2CK4BhUgOkCycx4xxG5Q9Gjy/V9Lf/79jE
         wBRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpP1qlNhUrjVwbTFARJHfj7psm5sXwG/R4ItOwlKi7p7ylItBhHEOT8hmCH8kozsueI7uVEc2acMNevO4QAGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEO+dzgWNMd23NGOHVGHi5R9txB6JS7tfb+YwwbDBQqrQF7L2V
	wWsIXe/YwOfu+l6iDxorjmjd5h45Z7N2sYiJVBTCd3qDaSmC/ZZFAj51kZ0Y068xJFtVwWnm0vZ
	33rosA2RZA8WrS7RSYkFTf7NYcOxxS45wldpN1cZFl/7kue6yoBW0XdyUDDXaExxTenJTBg==
X-Gm-Gg: AfdE7cmhkg2EVgZb7Qqrx1h4K+zSGiNRdu38qae36jTZrTW4vnv/hq5F24mGiMwmJMx
	MyYFGBSo25yjFN6My+JOZFG+10wp3AaaWD/h1gALMFDk2DbilybEFqGAMZOiztCXT0kvgbRyEBQ
	2lUxkUzx0Q6zus8bZ1LkDNaCzUzj5XsHy1V11V2/lGImWjNGHIBZzrzZDDKaBLLzZIWBHfjWaAf
	+z7mtgYVgJ8Nr8N1lmq53+YAnNUoqwv4ImpRFoKNurXgF0oN460R5Pn6HSybwX3uqTyJFdnxsmc
	y6pw7X69JHdEYDCISr6bWefZUqZ61c2sAzfd17EumkaOJ4CzlQ45Ct7RFz3a5DZUV03W4H5j4eC
	rkAHqtYi8YY/8YJOEf0JZRpzobkKiMftS1n6Hxl5RsgGFrtnNa7r/7To68DbXdAPLaQ==
X-Received: by 2002:a05:620a:2601:b0:92e:e314:c9ca with SMTP id af79cd13be357-92ef2c1fa96mr1459200885a.52.1784052468797;
        Tue, 14 Jul 2026 11:07:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2601:b0:92e:e314:c9ca with SMTP id af79cd13be357-92ef2c1fa96mr1459196685a.52.1784052468350;
        Tue, 14 Jul 2026 11:07:48 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:07:47 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org,
        Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20260702115835.167602-1-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
Subject: Re: (subset) [PATCH v9 00/14] firmware: qcom: Add OP-TEE PAS
 service support
Message-Id: <178405246411.4102418.8979771009872296240.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:07:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: fIPDaiZ75H2yXoz7uqxubGTDLUlJSXXo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfX7T2blMj7UY5u
 RSxbiv/GZhwOg8/WeOJyv55ZjiJj9Y4iQoJCUvkh9kN5xmEKFAUW2YCmHTI1zpA22E6HCCz/oUk
 E+abosqw+j57md2amUMHDLQLapx2FoJhrQ5iOyOJ+s+oTFgUVpJK3QHhDwxW+edQwZNc1l6JXAo
 o8bpsJoH3qznx238Bi8S6Cwouyst7uq4GF27mbVW+KvzmJ1oWpVd37PjBIAvOaITjiMv7WxfeLU
 sCeBVwATDHf9a8rkmv5Mshjpxu1GWh08rqp6NhyQF6Iur711+jPmWaIJ2fBF5U1Ko52yhlZVIlg
 X8e/3NBZkLHhQMQJGaOjkqBuoBTfv7vjTzqKhQCVLa1d2Sw5oH47JvGNJpK9uC4EW8+ZRcHDJ/3
 GthhhzNHXB55IRClConK1vzPtrqpmNOmF1jSGyLCBXGK25W88Z+EkaNWDcki2wO7E3J6E9scxB3
 LRgHTTB4rHgJUcQTD1A==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a567af5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=50BX1_4M625rkW4sIQwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfXy3bMRVkHOjcf
 7NlnnG5cJHse+HMwdFj3Z1EWQ2Hw0642oqY4ILYCevWAtQi0AI2W+59nfs4DUKUNn6zcGM8lzT+
 oQqYrdg28u7j1q8FP3yv6PvBlH/lJCk=
X-Proofpoint-ORIG-GUID: fIPDaiZ75H2yXoz7uqxubGTDLUlJSXXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-39100-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:konradybcio@kernel.org,m:sumit.garg@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm
 .com,m:jorge.ramirez@oss.qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6A75757BA4


On Thu, 02 Jul 2026 17:28:16 +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> [...]

Applied, thanks!

[12/14] wifi: ath12k: Switch to generic PAS TZ APIs
        commit: d418509383b0c884b70814ae85d3ef105a63b940

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


