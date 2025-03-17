Return-Path: <linux-wireless+bounces-20419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6AEA63ECC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 05:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D4716CB84
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 04:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8251F941;
	Mon, 17 Mar 2025 04:56:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B01CAB3;
	Mon, 17 Mar 2025 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742187370; cv=none; b=UCQm9I1ndfVYunVxptnsqWm5/B4e+grDpYJa+xmFrgmR6AVnZogGrjCOPgWm8Kn5v8EnyOaLyPQpWJIHK886z/bT79Dm1Q2AATrTjMVX9Q5dvi/oMUphk7GvYgA0MVuP5lNhe/KnwMdC/2dPPDkFtrW/17/PSpYfVTN/k5n89lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742187370; c=relaxed/simple;
	bh=I3Gc5xhdi0mXAQW7UmtNXCkWE+nW0L1ckJqUpEdeP7g=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=isLKOKP/jn9Mhh8ZgELA3gs7rUMzNXJr7blb9nqKUfs4KABthpZTR16Apri3j6nJU8xK1lPCg9xgSEpGU7pmRaSEzkwXJBxTHC6CtKUcp6mAVftpt8FzE3yfgvpleVY92+HGRv93grCxE7SF7r8rAQWMDs31lKmBF1wKV81psz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZGN2z6Sb7z4x5rk;
	Mon, 17 Mar 2025 12:55:55 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52H4tpl9005508;
	Mon, 17 Mar 2025 12:55:51 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 12:55:53 +0800 (CST)
Date: Mon, 17 Mar 2025 12:55:53 +0800 (CST)
X-Zmail-TransId: 2afb67d7ab59ffffffff806-09d61
X-Mailer: Zmail v1.0
Message-ID: <20250317125553028rN6mepsLlgyvSWxALaCDB@zte.com.cn>
In-Reply-To: <2bf53580ead86edc83de8f97d1b7de576d3ac3b2.camel@sipsolutions.net>
References: 20250315111254625RMIKeUh51j1Xk9CWuu2LT@zte.com.cn,2bf53580ead86edc83de8f97d1b7de576d3ac3b2.camel@sipsolutions.net
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <johannes@sipsolutions.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbWFjODAyMTE6IG1pbnN0cmVsX2h0OiBSZXBsYWNlIG5lc3RlZCBtaW4oKSB3aXRoIHNpbmdsZSAgIG1pbjMoKQ==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 52H4tpl9005508
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7AB5B.005/4ZGN2z6Sb7z4x5rk



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SSBzZWUgdGhlIGZvbGxvd2luZyBjb21taXTvvJoNCnxodHRwczovL3dlYi5naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9jb21taXQvP2lk
PWFiOTM2ODM2ZWMwOWZhMjM5NTRlOGU1Nzg1ZDcxYTQxZTVlZThiY2IgDQoNCkkgZG9uJ3QgdGhp
bmsgY29kZSBvcHRpbWl6YXRpb24gYW5kIHVuaWZpY2F0aW9uIGlzICJnYXJiYWdlIi4gSWYgc28s
IHdoeSBkaWQgeW91IGNob29zZSB0byBtZXJnZSBpbnRvIGEgY29tbWl0IGxpa2UgImdhcmJhZ2Ui
Lg0KSSdtIGp1c3QgYm90aGVyZWQgYnkgdGhpcyBhc3BlY3Qgd2hlbiBJIHVzdWFsbHkgbG9vayBh
dCB0aGUgY29kZSwgc28gd2h5IG5vdCBiZSBjb25jaXNlLg0KSSB3b3VsZCBldmVuIGxpa2UgdG8g
aW1wbGVtZW50IGBtaW40L21heDRgIGxpa2UgYGRtbF9taW40L2RtbF9tYXg0YC4gV291bGRuJ3Qg
dGhhdCBiZSBtb3JlIGNvbmNpc2UgY29kZT8NCg0KQXMgYSBuZXdjb21lciwgbXkgcGVyc3BlY3Rp
dmVzIG1heSBkaWZmZXIgZnJvbSB0aG9zZSBvZiB0aGUgZXhwZXJ0cyBoZXJlLiBJIGFwb2xvZ2l6
ZSBpZiB0aGlzIGhhcyBjYXVzZWQgYW55IGluY29udmVuaWVuY2UuDQpUaGFua3MNCg0KDQoNCk9y
aWdpbmFsDQoNCg0KRnJvbTogam9oYW5uZXMgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQpU
bzogRmVuZyBXZWkxMDMzMjcyMTtsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+Ow0KQ2M6IGxpbnV4LXdpcmVsZXNzIDxsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5v
cmc+Ow0KRGF0ZTogMjAyNS8wMy8xNiAyMjowMQ0KU3ViamVjdDogUmU6IFtQQVRDSF0gbWFjODAy
MTE6IG1pbnN0cmVsX2h0OiBSZXBsYWNlIG5lc3RlZCBtaW4oKSB3aXRoIHNpbmdsZSBtaW4zKCkN
Cg0KUGxlYXNlIGRvIG5vdCBzZW5kIHV0dGVyIGdhcmJhZ2UgcGF0Y2hlcy4gSXQgd2FzdGVzIGV2
ZXJ5b25lJ3MgdGltZS4NCiANCklmIHlvdSBkb24ndCBrbm93IHdoYXQgeW91J3JlIGRvaW5nLCBq
dXN0IHN0b3AuIFRoZXJlJ3MgdmVyeSB2ZXJ5IGxpdHRsZQ0KdmFsdWUgaW4gc3VjaCBwYXRjaGVz
IGFueXdheSwgc28gZG9uJ3Qgc2VuZCB0aGVtLiBGaXJzdCB0aGluayBpZiBpdA0KYWN0dWFsbHkg
ZG9lcyBzb21ldGhpbmcgdXNlZnVsLCBhbmQgaWYgaW4gZG91YnQsIGRvbid0Lg0KIA0Kam9oYW5u
ZXM=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZh
bWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+SSBzZWUgdGhlIGZvbGxvd2luZyBj
b21taXTvvJo8L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mb
hem7kSxNaWNyb3NvZnQgWWFIZWk7Ij58PGEgaHJlZj0iaHR0cHM6Ly93ZWIuZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9p
ZD1hYjkzNjgzNmVjMDlmYTIzOTU0ZThlNTc4NWQ3MWE0MWU1ZWU4YmNiIj48L2E+PGEgaHJlZj0i
aHR0cHM6Ly93ZWIuZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQv
bGludXgtbmV4dC5naXQvY29tbWl0Lz9pZD1hYjkzNjgzNmVjMDlmYTIzOTU0ZThlNTc4NWQ3MWE0
MWU1ZWU4YmNiIj5odHRwczovL3dlYi5naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9jb21taXQvP2lkPWFiOTM2ODM2ZWMwOWZhMjM5NTRl
OGU1Nzg1ZDcxYTQxZTVlZThiY2I8L2E+IDwvcD5JIGRvbid0IHRoaW5rIGNvZGUgb3B0aW1pemF0
aW9uIGFuZCB1bmlmaWNhdGlvbiBpcyAiZ2FyYmFnZSIuIElmIHNvLCB3aHkgZGlkIHlvdSBjaG9v
c2UgdG8gbWVyZ2UgaW50byBhIGNvbW1pdCBsaWtlICJnYXJiYWdlIi48YnI+SSdtIGp1c3QgYm90
aGVyZWQgYnkgdGhpcyBhc3BlY3Qgd2hlbiBJIHVzdWFsbHkgbG9vayBhdCB0aGUgY29kZSwgc28g
d2h5IG5vdCBiZSBjb25jaXNlLjxicj5JIHdvdWxkIGV2ZW4gbGlrZSB0byBpbXBsZW1lbnQgYG1p
bjQvbWF4NGAgbGlrZSBgZG1sX21pbjQvZG1sX21heDRgLiBXb3VsZG4ndCB0aGF0IGJlIG1vcmUg
Y29uY2lzZSBjb2RlPzxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/p
m4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxzcGFuIHN0eWxlPSJj
b2xvcjogcmdiKDUxLCA1MSwgNTEpOyBmb250LWZhbWlseTogJnF1b3Q7UGluZ0ZhbmcgU0MmcXVv
dDssIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTZweDsgYmFja2dy
b3VuZC1jb2xvcjogcmdiKDI1NSwgMjU1LCAyNTUpOyI+QXMgYSBuZXdjb21lciwgbXkgcGVyc3Bl
Y3RpdmVzIG1heSBkaWZmZXIgZnJvbSB0aG9zZSBvZiB0aGUgZXhwZXJ0cyBoZXJlLiBJIGFwb2xv
Z2l6ZSBpZiB0aGlzIGhhcyBjYXVzZWQgYW55IGluY29udmVuaWVuY2UuPC9zcGFuPjwvcD48cCBz
dHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZ
YUhlaTsiPjxzcGFuIHN0eWxlPSJjb2xvcjogcmdiKDUxLCA1MSwgNTEpOyBmb250LWZhbWlseTog
JnF1b3Q7UGluZ0ZhbmcgU0MmcXVvdDssIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZv
bnQtc2l6ZTogMTZweDsgYmFja2dyb3VuZC1jb2xvcjogcmdiKDI1NSwgMjU1LCAyNTUpOyI+VGhh
bmtzPC9zcGFuPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v
6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4
O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9wPjxkaXYg
Y2xhc3M9InpoaXN0b3J5Um93IiBzdHlsZT0iZGlzcGxheTpibG9jayI+PGRpdiBjbGFzcz0iemhp
c3RvcnlEZXMiIHN0eWxlPSJ3aWR0aDogMTAwJTsgaGVpZ2h0OiAyOHB4OyBsaW5lLWhlaWdodDog
MjhweDsgYmFja2dyb3VuZC1jb2xvcjogI0UwRTVFOTsgY29sb3I6ICMxMzg4RkY7IHRleHQtYWxp
Z246IGNlbnRlcjsiPk9yaWdpbmFsPC9kaXY+PGRpdiBpZD0iendyaXRlSGlzdG9yeUNvbnRhaW5l
ciI+PGRpdiBjbGFzcz0iY29udHJvbC1ncm91cCB6aGlzdG9yeVBhbmVsIj48ZGl2IGNsYXNzPSJ6
aGlzdG9yeUhlYWRlciIgc3R5bGU9InBhZGRpbmc6IDhweDsgYmFja2dyb3VuZC1jb2xvcjogI0Y1
RjZGODsiPjxkaXY+PHN0cm9uZz5Gcm9tOiZuYnNwOzwvc3Ryb25nPjxzcGFuIGNsYXNzPSJ6cmVh
ZFVzZXJOYW1lIj5qb2hhbm5lcyAmbHQ7am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldCZndDs8L3Nw
YW4+PC9kaXY+PGRpdj48c3Ryb25nPlRvOiZuYnNwOzwvc3Ryb25nPjxzcGFuIGNsYXNzPSJ6cmVh
ZFVzZXJOYW1lIiBzdHlsZT0iZGlzcGxheTogaW5saW5lOyI+RmVuZyBXZWkxMDMzMjcyMTs8L3Nw
YW4+PHNwYW4gY2xhc3M9InpyZWFkVXNlck5hbWUiIHN0eWxlPSJkaXNwbGF5OiBpbmxpbmU7Ij5s
aW51eC1rZXJuZWwgJmx0O2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcmZ3Q7Ozwvc3Bhbj48
L2Rpdj48ZGl2PjxzdHJvbmc+Q2M6Jm5ic3A7PC9zdHJvbmc+PHNwYW4gY2xhc3M9InpyZWFkVXNl
ck5hbWUiIHN0eWxlPSJkaXNwbGF5OiBpbmxpbmU7Ij5saW51eC13aXJlbGVzcyAmbHQ7bGludXgt
d2lyZWxlc3NAdmdlci5rZXJuZWwub3JnJmd0Ozs8L3NwYW4+PC9kaXY+PGRpdj48c3Ryb25nPkRh
dGU6Jm5ic3A7PC9zdHJvbmc+PHNwYW4gY2xhc3M9IiI+MjAyNS8wMy8xNiAyMjowMTwvc3Bhbj48
L2Rpdj48ZGl2PjxzdHJvbmc+U3ViamVjdDombmJzcDs8L3N0cm9uZz48c3BhbiBjbGFzcz0ienJl
YWRUaXRsZSI+PHN0cm9uZz5SZTogW1BBVENIXSBtYWM4MDIxMTogbWluc3RyZWxfaHQ6IFJlcGxh
Y2UgbmVzdGVkIG1pbigpIHdpdGggc2luZ2xlICAgbWluMygpPC9zdHJvbmc+PC9zcGFuPjwvZGl2
PjwvZGl2PjxkaXYgY2xhc3M9InpoaXN0b3J5Q29udGVudCI+UGxlYXNlJm5ic3A7ZG8mbmJzcDtu
b3QmbmJzcDtzZW5kJm5ic3A7dXR0ZXImbmJzcDtnYXJiYWdlJm5ic3A7cGF0Y2hlcy4mbmJzcDtJ
dCZuYnNwO3dhc3RlcyZuYnNwO2V2ZXJ5b25lJ3MmbmJzcDt0aW1lLjxicj4gPGJyPklmJm5ic3A7
eW91Jm5ic3A7ZG9uJ3QmbmJzcDtrbm93Jm5ic3A7d2hhdCZuYnNwO3lvdSdyZSZuYnNwO2RvaW5n
LCZuYnNwO2p1c3QmbmJzcDtzdG9wLiZuYnNwO1RoZXJlJ3MmbmJzcDt2ZXJ5Jm5ic3A7dmVyeSZu
YnNwO2xpdHRsZTxicj52YWx1ZSZuYnNwO2luJm5ic3A7c3VjaCZuYnNwO3BhdGNoZXMmbmJzcDth
bnl3YXksJm5ic3A7c28mbmJzcDtkb24ndCZuYnNwO3NlbmQmbmJzcDt0aGVtLiZuYnNwO0ZpcnN0
Jm5ic3A7dGhpbmsmbmJzcDtpZiZuYnNwO2l0PGJyPmFjdHVhbGx5Jm5ic3A7ZG9lcyZuYnNwO3Nv
bWV0aGluZyZuYnNwO3VzZWZ1bCwmbmJzcDthbmQmbmJzcDtpZiZuYnNwO2luJm5ic3A7ZG91YnQs
Jm5ic3A7ZG9uJ3QuPGJyPiA8YnI+am9oYW5uZXM8L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48cD48
YnI+PC9wPjwvZGl2Pg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


