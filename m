Return-Path: <linux-wireless+bounces-4932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58EC8808A9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 01:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983AA1C20F85
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 00:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE64685;
	Wed, 20 Mar 2024 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jQKvwGNZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EBB2904
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895343; cv=none; b=T0VMaxbo3Cd82aG82HHyLmaXoOwUO0ILhN/dJm1rYDoSBqi4CnG14c32pC7R+HJ/WdeOZdwrzMaliCv+/+EWBSA0pKnXsFFehNGbxOIXOwA+dinWs0odkBeraScYhFKEp4fEvJa7aCRV7nj1ZKkQ+AVuFDO6OPsOZDd5jMIMyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895343; c=relaxed/simple;
	bh=eDCCyrEIxjjXZjmAOHkJjwnDrF9aFnzlqxo6rUPKKHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yrnaql8aQtjD/4IlNR4/iRE6CaYynbFLbjSqsI4+pDZUexrfDqVPoVWNgSzkKPsYdux0qKE65vUcWcP4nAkSENibC/WHBSBkA3QLXCp7q+NULAdBwGnHZN5i9XDICoSLNMn6aQRqZgBnUzEz3RpTF3htK6KD8ZM11X2KkE7OWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jQKvwGNZ; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id mNgzrPQXKl9dRmk23rOJIu; Wed, 20 Mar 2024 00:42:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mk22r1j6Zkyhrmk22rmb0r; Wed, 20 Mar 2024 00:42:14 +0000
X-Authority-Analysis: v=2.4 cv=Z9TqHmRA c=1 sm=1 tr=0 ts=65fa30e6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=9MzSDiJ5aBsJ5ggNAYYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C0e07c7tUncIYZeoirLLjhFyd9DWTwguNB6M2w9ToKU=; b=jQKvwGNZ137+7vtiHui2rYOKmH
	IgMmALF64IXqM6Z2nVNyKnAcL+hVI3EWGatWtCNanCTX61DCV9PXSVFo9SoLFMrKHF7XKzWq8LKuZ
	+IwONtjEoxW+zyTHi1Ig8e6Ja++CqLtVMVh6Q9tW3KIOdY35h0SW/a9Sj1P1E4mRgBA8aw/pjJukf
	Y1A869t84U3xD4fFrpSmtZrxx0wju/JBoblRK2I+QvHaE4+8/5cPvJcdvPw20n7E9czzLdNp2AP8p
	r0KpuT6KDH28Dld990MzI5+fZ/PfdZ1JYGQuVuQbUebFHjAnybKPWB0HHCre86GkV76epczsO8gpr
	7bq/2Udg==;
Received: from [201.172.174.229] (port=43928 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rmk21-003lXB-2i;
	Tue, 19 Mar 2024 19:42:13 -0500
Message-ID: <483362b8-ea79-4036-89eb-d6ab737e1e96@embeddedor.com>
Date: Tue, 19 Mar 2024 18:42:12 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] wireless: ti: Can we just remove this flexible array?
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
References: <3a531d5b-9bf6-4e88-ba8c-a76cfa95be20@embeddedor.com>
 <328306d9-953f-482b-bf9a-a753d7d4e2ed@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <328306d9-953f-482b-bf9a-a753d7d4e2ed@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rmk21-003lXB-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:43928
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCAC62KMUkM+yK8Rb/3W+YimB8zjyXDdG8gwlYzJgSc/3ns8ufTEyOsFowdu7mW8GmOm3Ea7ve1/APPyf8IKt3Fu8mEKrl5NrMazrAh0xTIkcNSws59G
 U0iMwHGjLMxVp7XV8WdMyRXf4EWL7DUSHaU+triqeNnAqBl3n8dnClHG2fUb7kAKtX+p/vStduQHIv8ttam3x4pdFpaHdhf/nvf3GNV2ZhhYM1lHRnzdholb



On 3/19/24 16:54, Jeff Johnson wrote:
> On 3/19/2024 2:59 PM, Gustavo A. R. Silva wrote:
>> Hi!
>>
>> `struct wl1271_cmd_header` is currently embedded in multiple other
>> structs, and it's causing many `-Wflex-array-member-not-at-end` warnings.
>>
>> Has this flexible-array member been used in the past or is it intended
>> for future use?
>>
>> Otherwise, I think we could just remove it.
>>
>> diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
>> index f2609d5b6bf7..4c2f2608ef3b 100644
>> --- a/drivers/net/wireless/ti/wlcore/cmd.h
>> +++ b/drivers/net/wireless/ti/wlcore/cmd.h
>> @@ -208,8 +208,6 @@ enum cmd_templ {
>>    struct wl1271_cmd_header {
>>           __le16 id;
>>           __le16 status;
>> -       /* payload */
>> -       u8 data[];
>>    } __packed;
> 
> I'd think you should just remove it
> 

Yep, I think I'm actually going to remove a few more:

diff --git a/drivers/net/wireless/ti/wl1251/cmd.h b/drivers/net/wireless/ti/wl1251/cmd.h
index e5874186f9d7..39159201b97e 100644
--- a/drivers/net/wireless/ti/wl1251/cmd.h
+++ b/drivers/net/wireless/ti/wl1251/cmd.h
@@ -89,8 +89,6 @@ enum wl1251_commands {
  struct wl1251_cmd_header {
         u16 id;
         u16 status;
-       /* payload */
-       u8 data[];
  } __packed;

  struct  wl1251_command {
diff --git a/drivers/net/wireless/ti/wl1251/wl12xx_80211.h b/drivers/net/wireless/ti/wl1251/wl12xx_80211.h
index 7e28fe435b43..3d5b0df5b231 100644
--- a/drivers/net/wireless/ti/wl1251/wl12xx_80211.h
+++ b/drivers/net/wireless/ti/wl1251/wl12xx_80211.h
@@ -65,7 +65,6 @@ struct ieee80211_header {
         u8 sa[ETH_ALEN];
         u8 bssid[ETH_ALEN];
         __le16 seq_ctl;
-       u8 payload[];
  } __packed;

  struct wl12xx_ie_header {
diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
index f2609d5b6bf7..4c2f2608ef3b 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.h
+++ b/drivers/net/wireless/ti/wlcore/cmd.h
@@ -208,8 +208,6 @@ enum cmd_templ {
  struct wl1271_cmd_header {
         __le16 id;
         __le16 status;
-       /* payload */
-       u8 data[];
  } __packed;

  #define WL1271_CMD_MAX_PARAMS 572
diff --git a/drivers/net/wireless/ti/wlcore/wl12xx_80211.h b/drivers/net/wireless/ti/wlcore/wl12xx_80211.h
index 1dd7ecc11f86..602915c4da26 100644
--- a/drivers/net/wireless/ti/wlcore/wl12xx_80211.h
+++ b/drivers/net/wireless/ti/wlcore/wl12xx_80211.h
@@ -66,7 +66,6 @@ struct ieee80211_header {
         u8 sa[ETH_ALEN];
         u8 bssid[ETH_ALEN];
         __le16 seq_ctl;
-       u8 payload[];
  } __packed;

  struct wl12xx_ie_header {

--
Gustavo

