Return-Path: <linux-wireless+bounces-33159-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMoiN1Irs2ksSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33159-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:08:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E95279C8D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 524B231D720D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD5F383C66;
	Thu, 12 Mar 2026 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="b5ZwDlzx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE3F37D130;
	Thu, 12 Mar 2026 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349524; cv=none; b=H4wf2wDP7zKdu55uqvM9pc+QLkZZ8lLkgm7DKkHr1CcKleFQuqhNLyWDgPZGzv66/Wr1kBt1JylkHQLirflkHQBmD94qPeiKIW7Jj0+r8rpMEYhqMZOvXjpfBDPFoqautuntE0nGgrj2JwAOqhNp1UWiRaKERBZlEOlSCi+RK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349524; c=relaxed/simple;
	bh=LiUETGLy0+GbzN2rHCbErYbuTcNN63E3BcwagkS4W90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLCWwvZ4nSyMKSAByyPnesOxaZUcbTYVgwzGHpTt+zM+cTef9JjbMkI2LCaG8GWzZGElyXkG7ttFglYyNpXxQirpg0wa1RgO93vsh88LJIO1T0DRANM7DA9AVEoe6TVcMhIpAQpUVMANrn+9kYsdLPqqZ6Ms8iLcbZhNL/W47rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=b5ZwDlzx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773349520; x=1773954320; i=georgmueller@gmx.net;
	bh=pHLOUdZYSBWHZS8VsRv5mxWwJswoGN6YsiURvNRyo/8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b5ZwDlzxY+wjvXL4QZ2Zuv97yiPwYX/TRWCS08oGCMN89almxa2f2MeTdan/ll5q
	 6MsYiIEwX+o2HBhELFBpt4NDoRQeTIbIHCR01zUBGascGNp+bPpcYP1ZpnY1SV2Bw
	 u7C+cxnNGwN6gXru/4qmcq2h4UxboATmVxoJbJWoSZJEIkRX51nzJ78qg/c6tJFWH
	 kQX51kUhXedY2G393U5Y2b1OUJX1umSiYvEs80dQygZKECCjo+DFrI9Y0j8kwv/oX
	 xBsuzQwwLeb0FRe7ELjblJ9FHaD1cNuqwy6Da6tx6E92MNl8KIxiAr6pYaEw+LhPf
	 ykEP9M1b/Q91dSyuuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1w0WEj02CH-005OvD; Thu, 12
 Mar 2026 22:05:20 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH] wifi: rtl8xxxu: handle rate control for 8188e a per mac_id
Date: Thu, 12 Mar 2026 21:58:53 +0100
Message-ID: <20260312205851.2830364-3-georgmueller@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d622184a-36b2-4df6-bea2-7f5c6ba9b22a@gmail.com>
References: <d622184a-36b2-4df6-bea2-7f5c6ba9b22a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:31EihtmzzJ8Qc8B2babaeqHv7KXSU2QN4RuUMbkEC0RmLOMcGzv
 3Pg6z6bINp9VlCbV90V1upnxpXsEEnwLeYgBDe9e/jrmBjLrFzXlwhqJb9PdtaFDi4Dvlc2
 IlrMwHSaMLO4ci/MpzV5rO+TeNK6qt3EdLaVzFM8HEjn9TfXzyPFyekufV7xYY9Wc5S3Zgg
 0m3C3vcFuICEfe+Eue98w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E2c6St6h1zQ=;/R0DqW4omBdr0jxC+V4o+/pKQi2
 03m3NAwjnq5hV/RjLx2I2okF+NOiOGosxIJ+UD8riHXQvOFEnNHwIyMQW/oOMaU7egIiTw9Ku
 sB7nh4m832U53YDzuzq/NmJE4efgFh5s2fjHRPAzjhHyJwxHXHOIIcD8CmSuaxnr9DGela60W
 G8WsFhNgTppLjZ/q10y3ruegCJPRYaRiwwwDBzdfy2ZxEp16TAbe2/PT7YYpDQZEkUSffMyrg
 PiE+RU0UjsBPm7RLlLvHiNw6OubI+Hf7uZ4RtRY225mjCHVg+LIxMgxQ6gysxUo+ovs+2Wg8f
 3ifn0tm244l3Q5iYk5ojPf03NJ62dkT8q5JIQzWiHnY5YM5Zdl0Ap7t+ihc7LzwDW2/v+EwAy
 rm8FGnpiEHk0PgQcFTwgFUi1TpUyqRY9j2wHUCZw2eolzJtIwuC7yYHZw6aTECwOLls90xyCa
 wnAv8tGijW9+q+/2YNUioVmxDfLXnk2UZeWXS3PJ/SefLasLVDxipt5CZlalZWTCjHjnvQsMU
 X0Jk1FmbPaBw/sBMjHPWm1II3zx5BUJqE/Y/TsQ7LmIOtIBP1svtUPqBOlg82r+PBV+I5KsKA
 FIMc8vlG8E1h6qvxv9ANJYqtrwSnnN6Y6xFBn4AU9Cm1aV95cyN2ft/oUc0EJ5cUmaYDhJTA5
 sGnELmmom79Ha+xLAoDKhxHaogWDwAOS3ox5CMN2HeftJMQvsy79adfqbhMCHfLwmrj0PAv25
 UCXsVEDb0VeBtoPKtd1qlWQoncz5z6+ZoPiZlW8eghJrWkekVW53JPG9rYVFnNDtcniJCTfrb
 fcGBPX6HAN/CZSed5SOJRgotIDSbX4YxMSFD7Xg3W5KSXqCbm4atQMVLpPchNzpAjTbB+qoMx
 aU3C9o8W4DEa/WiqI2rgZjGkimvqiCuKod17Ig6x/3c+luLSwfMUmbp9+qtVuPnMAkVyQFcv2
 F62dwvMD212BeFzE1v/Ue2QQrJjoZAtN7GhlhCi1DEc/KJ77PAw2rtvkBZV10zMW2nqPYQLbc
 T/QZmMvyfGJ52LC1UNlmloKvtZvLw/+bGgNgO2+cZzg7it27IwBAmrOnILHYR6xzs6lWSTyKz
 LG49UhMYU7v6AkFQtQgYKzFDDrZRWfldkTixUG6Tmo5RYwIo+/DgEDSv1UlS8f7v8b5qS4dhn
 UI1fQzI1eQnvicwcLpNUFnIRSwzHsOb4UELevu+yEDkjo36SMrAy+2nwWDdeMMAdm9sWawCE1
 Um0YJSNixxj59dLU4G1UsXcqA/47EEPOrhh0jxoG/KdNaOBDVlHFvRqbU9QpC7wlWpyPKCxYr
 x6eYwCq+GeT9WyZFoHPg4NiOXEm4ptfGVykUZRiuX05nbSlEOrD45u3DKg8HXGyfCiNL4UQib
 zal0ZhnIiDoF1QnxnUUdxAuBHMEzsb3xnB5sBYpjMp1mA7bd+fgM3fDrO+91MkzxOjWUUhctF
 0ghnuuIuybee1z3XYWKaZm0jqcJrfcKxLbGj3agSMptboGMAC1eb2/49H2k1dP0PZuoT8eOHo
 6uo/pqEP8pgl3wqLqtdnjqhBsAv4fPo2oI9Hoi9BLONwuAz1xnlqVCvv0IY6qsaemlaBNah2O
 g592PkCArKu3NQWpEGiuI/s7KiuIncypk4FqkP2GC+fSiJLcfK2RizBAtaBts75rftpQ3rHLd
 I++U5c3folWEhy1+G71FD0tDLRPU1ceXUEuCiqHP21SgYQTlyFdhEJjulcOQ5FP6wnwmAqbf2
 U6PaDFQcmaOkIrhMcVrPn4n+mGmG6mm7+cgbf8UQcW9su+sq33Ruqi1ooUSKt2l8krwFDiB0j
 IEjMummD4nwSzlNo0E3divoaoXCGiYi1X1iMD5EcNelpdXuA2pP5/6jBI3qTZkX+tj2GIMxBu
 EoySNVoqmLzUtQFfelAMj7aMe5HfxengPdSR2F4rUggaIrxVrl8CAjsIJhvRESmHVi7wKbUGa
 ednfbF8oguHMRbJt39hE+Zewj804J0vv7B6qDvL1hRkQqY/BcGSjNoXYszWFSTYQ2PwkDSgWF
 T1+dwomZ+IpMXlqeZxJ4SE6iULGQVGZWed/9nUB0ivTc+H+ZebiT0m6azaycjx/0bHP5Bbq8R
 9iELpRRbTqj0XYrpkLaRkvWmdIDk1LvbjW40j3hTxjRkqmhXMwltKAnDq63Re+jZ5of++vJ8S
 sCJO9slua6fKE9ZHj1V+hKBqU8xhe5ZnEFwe8ClbYzlOGMDFGZ04I1/gRHIW8E1ZS9zXVjWRt
 lk/sNrx99f8Rv8ixzlVyn7ShbSfWTuLznVPZ+XSb7cjND3Cb0woWf0l/i3ZXL99eamAX/KQeX
 J/BjjlSuu/QwPfa75ZMnyKMkvVRQAHwc6p8BF1bl2MThhQnjORNE1aFe//mQt1vyuA7uKiRLe
 h8jyA88Nt/iX5+ned1NO26ZdPYvpDv1taFV9lMoBnuONBZlXsD9HGj8PnpCbx/+iYlgstORZo
 2vXwjd9kja/uNwEbjQIvFoZ2Ef/jvtzxBpxP7khd9/a6Dd9YqB9pU6u4Ht0bwGMTZ1N0yfh72
 /AEO8//CbBqd3H8bTb1VX0SmkEx+o5/G010mhpM/OwgpNYGIYvBCgs8UuqIEqRPpOl4IrOZdm
 9EnRBTr+opLinyKoLqPgZe00Qey5qRyi1qGn8d2zjauD5VAYJFBx/I+d2EKio3TCRl6FIakDx
 h0bHDypeWVUcySq65ZzTX8mI97lGUbJphqwVrz2/69itSYWZZ/Ra8rHOx3t0oBv20gCXFaH3t
 cj4ddNrksxecNrgaqpUZkDLxRZkAvlMp4X/raC1j1Wslh8KH/9ir6I9jW0WqSA9dGlT98wO9N
 AiW8U1Q/UZBrEC/CvtfUM4dBWWCVZMj7+CVdhYJVTOY9afCrqex8bbTm65jrb0AmVb5L03HeZ
 mP5NulxaXuOZQTh9Z4JJalFS1zxG4rLxhTO2fg2sMbClYyeh6V14rfoM8qy6c9P9aEK3gyZ67
 M82Ut149uDE8kODsbom2tHN8sG24gOnIdkFM3BobbZT6Va3GiIUybyo7AT8fzL7SOb1Kodmys
 rJxs79pVTXHIhkoA4aA2uyCgCAAapfNp9XkvlS6b1t2RmyN5tD6sutwLepzMCE7vjHsy0Iq0m
 8N9sg8xa8PC/gaTQHQ1sKDYxmpNaGe5a+HYk0s43RftGgB+5LN+U9iYIIgj1GNFU+3+iY26n+
 Wm0/a+uYkxVs2+yAmzfumEpHXRB4aQ6qUuNE7JeOckoWwc+vOkQ7poP1cKYKrW42Kq0PnHH8v
 szPLC7BilaBt4k3TaOCGqMFeU9hqZHzuJ+1fcsoFacsYsiXg/FvA/MWSxcF6ltWdO6x0n0ioG
 1tTl5Sxf2A5tO8Tf6tEqIQHjK34e42UHICF6uxnfHydQCPitXI6WM55DzM+vXz3WY4M19OwNi
 TpN6SZQoJv/07+VuqYc2K6weLCinbc/BqSU0/Luwd2JDto4VTTuI9YUd9bXmNxb9Es8jDLkJ6
 DBtUqlOvy6c/fe01JzJlzGYvm9RpoC6Ps4hiQbgbSnl1UkSxx6s1V2twRQhjJoGd65HbZKITz
 c5HFLTKmVldiv0q4OLiqKwfZi15neptaxJTd6Jmvse2vHtsqvUCBBZaYrW6JIjHdnjIRS19kR
 /c1jYIDDYfjJn5hN7axewTfZmjB3bbgI/yN1FySq5bS5D+tEMVDvg2qxkGbXCrK73x2jTZWkd
 jad8SHPbPwgmmeAW/bkR7lYsTgRiU6l2YOZ/Hv0CQdfXwN8aaD2F6o8KjCG9ERnsFw9U/G72Z
 LSeslqA2UzW2VQVPv2kTnKZCxwW/+gqQoh8PHWlBxfPUr9PaZzCl8CqUwlJDBwVoDoD0Wt6qv
 KziCwDwWPp7irXaBlcC7EC3mHwVZZjfzNreE4KGrXH+BqWkPJvBwsek6GvgbQvuShnGUdlqpS
 PpW4PQernmIdWQWmTrSthrDMeO4orPvY5+ypaRPCPPKtwqzRxsYGTZZm/MoVgZKAAxCeLmPEL
 yHpMNrksIUQluAZFjuAyJoxYujRkMxzkO9HrVThDg/S2WGwHOPp800snlnWgR87/mA3chV0iQ
 YHp53NzlVmBxQx1P+KImTmfem4ztgcX2ac5DXQGMA/qv8ASw5K4UzLSpsyWjwZy4ndGj7uKsK
 e0bkY6yKPFFcuwX43kKCxpPdmahM8+Cr2tcsw/rjM+mPydd3HAxZnp8PfeWa96SjTfDUwe8lS
 X12Fbn1ublu6KX2LPGXLDtYzjOnMNbv9dfOTbARV2GPYX3cRx5zfGpDpyzWhDJoOG2F29/4Gx
 2OPU3Se3z6H8XIzQcBjtywMvyRtJOuCkGTcuyO2R/BVh+ewl+azcENjaDuHYkm+bfYb95zGAa
 bqsiStlXonEmEu7rgSMQpe+MwJWVBMV1g7onayPU3AGkMpU/0scB4Xzb1z57cFL1Wa3S+EVhc
 LpR7q4VaSM/uR7W2M5xweIPIS6qSwgH88lgS1XTXxdMKNGBnPUXOJJw5AhsIvqIakKtWahkCE
 HQ0t+0zV5BMM3O46J0nr27+6o6zGfE7xRANSz1j9UDrAdtc6B3d4WPnLYsQ9Q9xxGxjv4rC/v
 10zu4Jz7KEUnE8gT2Fzr8E6In6aL5uD69fmS69VMD396TIdS50GB/iW/H5fe9NK1VHi7Z6zF6
 RZGyLFUug4J3kDdWl2JWxGV0A5bbjfdF396nwgNu9gtkdBm0GbXxpoPUVda5xxkYpqnR60hIU
 StreOM3qUm8hagStgxqx0i6Cc4JGGPfmcCXXtJHExxeinNSvdA1+P81jK+KadW87TBxv0Ov3M
 iD6KIbBmes5MZgS3McMv4nalQyKQ6gR0arNcKhFxl1/NrmaLl4eHerJSto74KRu10MH45BGvE
 ed0bdiJYZ2DDdXAW4QU5yKq7j+roCcX/gH+tKxiTLmuya9Mh0Cpdv16XlIIns6GPuuPESTAUs
 czF8ZIUjd9gnLUddAg87Djw6DZgXlFdtyfO6p3iJgDloh9rTQGrjK+W15hT0m/er4BOPvSxa0
 p6d+HWrgeka4nlBxcFvNhVcWTaZZn2hTm65JPuZkVxL69Ht7JsSAwuQiCLHLUAIGKIe2A6J0p
 /lEgehzgGNhUwH7Q3Ezt5GyJPY5kVxjcjaX71sCG8ZLxztCJOVrZ1aJ2zd3KLan+yluSwEtiK
 Hk3pO+PYcQ3bz5zwVVksKmpR6sl4qtHFKgivFyNb8UzIIQn9bogkL4tb5cLcE+mcuaGhynK8A
 hpUqX+gin5uDNpE7CzcF0MnYGx5jmOYSCbV5S2/Tmths7SyKhbsOTxzgqf+iVmhKomqJs1M8x
 yicSZay3ae3Pj/37/0Gga9H2LV3RQAMggLxe8J715ToWwo6V+OfhRr+RDPRo/1s=
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33159-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58E95279C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

convert member ra_info to an array with one entry per mac id. This
allows having different rate control settings per connected station
in ap mode.

The max_macid_num is conservative. The old driver used 32 [1], some
other sources said 64 [2]. I have not enough adapters to test any of the
higher values. Given the usage of this chipset in nano dongles, I think
the 16 might be high enough.


I am a bit unsure about the handling in of priv->vifs in
rtl8188e_handle_ra_tx_report2():

The comment says "We only use macid 0" with the remark of not handling
AP mode, but priv->vifs has only two entries (no the number of mac_ids),
so I don't know the relation between them.


[1] https://github.com/lwfinger/rtl8188eu/blob/f5d1c8df2e2d8b217ea0113bf2c=
f3e37df8cb716/include/sta_info.h#L28
[2] https://lore.kernel.org/linux-wireless/27e83382-4c84-1841-c428-d1e5143=
ea20c@gmail.com/

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c    | 12 ++++++------
 drivers/net/wireless/realtek/rtl8xxxu/core.c     | 11 +++++++----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h |  3 ++-
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/w=
ireless/realtek/rtl8xxxu/8188e.c
index 766a7a7c7d28..ca044979ba79 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1468,9 +1468,8 @@ static void rtl8188e_reset_ra_counter(struct rtl8xxx=
u_ra_info *ra)
 	ra->nsc_down =3D (n_threshold_high[rate_id] + n_threshold_low[rate_id]) =
>> 1;
 }
=20
-static void rtl8188e_rate_decision(struct rtl8xxxu_ra_info *ra)
+static void rtl8188e_rate_decision(struct rtl8xxxu_priv *priv, struct rtl=
8xxxu_ra_info *ra)
 {
-	struct rtl8xxxu_priv *priv =3D container_of(ra, struct rtl8xxxu_priv, ra=
_info);
 	const u8 *retry_penalty_idx_0;
 	const u8 *retry_penalty_idx_1;
 	const u8 *retry_penalty_up_idx;
@@ -1669,7 +1668,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_p=
riv *priv, struct sk_buff *s
 	u32 *_rx_desc =3D (u32 *)(skb->data - sizeof(struct rtl8xxxu_rxdesc16));
 	struct rtl8xxxu_rxdesc16 *rx_desc =3D (struct rtl8xxxu_rxdesc16 *)_rx_de=
sc;
 	struct device *dev =3D &priv->udev->dev;
-	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
+	struct rtl8xxxu_ra_info *ra;
 	u32 tx_rpt_len =3D rx_desc->pktlen & 0x3ff;
 	u32 items =3D tx_rpt_len / TX_RPT2_ITEM_SIZE;
 	u64 macid_valid =3D ((u64)_rx_desc[5] << 32) | _rx_desc[4];
@@ -1688,6 +1687,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_p=
riv *priv, struct sk_buff *s
=20
 	for (macid =3D 0; macid < items; macid++) {
 		valid =3D false;
+		 ra =3D &priv->ra_info[macid];
=20
 		if (macid < 64)
 			valid =3D macid_valid & BIT(macid);
@@ -1704,7 +1704,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_p=
riv *priv, struct sk_buff *s
=20
 			if (ra->total > 0) {
 				if (ra->ra_stage < 5)
-					rtl8188e_rate_decision(ra);
+					rtl8188e_rate_decision(priv, ra);
 				else if (ra->ra_stage =3D=3D 5)
 					rtl8188e_power_training_try_state(ra);
 				else /* ra->ra_stage =3D=3D 6 */
@@ -1781,7 +1781,7 @@ rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv=
,
 			  u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
 			  u8 macid)
 {
-	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
+	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info[macid];
=20
 	ra->rate_id =3D rateid;
 	ra->rate_mask =3D ramask;
@@ -1792,7 +1792,7 @@ rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv=
,
=20
 static void rtl8188e_ra_set_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8=
 rssi)
 {
-	priv->ra_info.rssi_sta_ra =3D rssi;
+	priv->ra_info[macid].rssi_sta_ra =3D rssi;
 }
=20
 void rtl8188e_ra_info_init_all(struct rtl8xxxu_ra_info *ra)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wi=
reless/realtek/rtl8xxxu/core.c
index 794187d28caa..570b1d58e475 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -3921,6 +3921,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw =
*hw)
 	struct device *dev =3D &priv->udev->dev;
 	struct rtl8xxxu_fileops *fops =3D priv->fops;
 	bool macpower;
+	u16 mac_id;
 	int ret;
 	u8 val8;
 	u16 val16;
@@ -4393,9 +4394,11 @@ static int rtl8xxxu_init_device(struct ieee80211_hw=
 *hw)
 		priv->cfo_tracking.crystal_cap =3D priv->default_crystal_cap;
 	}
=20
-	if (priv->rtl_chip =3D=3D RTL8188E)
-		rtl8188e_ra_info_init_all(&priv->ra_info);
-
+	if (priv->rtl_chip =3D=3D RTL8188E)	{
+		for (mac_id =3D 0; mac_id < ARRAY_SIZE(priv->ra_info); mac_id++) {
+			rtl8188e_ra_info_init_all(&priv->ra_info[mac_id]);
+		}
+	}
 	set_bit(RTL8XXXU_BC_MC_MACID, priv->mac_id_map);
 	set_bit(RTL8XXXU_BC_MC_MACID1, priv->mac_id_map);
=20
@@ -5338,7 +5341,7 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, str=
uct ieee80211_hdr *hdr,
 {
 	struct rtl8xxxu_priv *priv =3D hw->priv;
 	struct device *dev =3D &priv->udev->dev;
-	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
+	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info[macid];
 	u8 *qc =3D ieee80211_get_qos_ctl(hdr);
 	u8 tid =3D qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate =3D 0;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/ne=
t/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 9fb2583ffffc..6a415b9c3bd9 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -76,6 +76,7 @@
 #define RTL_FW_PAGE_SIZE		4096
 #define RTL8XXXU_FIRMWARE_POLL_MAX	1000
=20
+#define RTL8188E_MAX_MAC_ID_NUM		16
 #define RTL8723A_CHANNEL_GROUPS		3
 #define RTL8723A_MAX_RF_PATHS		2
 #define RTL8723B_CHANNEL_GROUPS		6
@@ -1916,7 +1917,7 @@ struct rtl8xxxu_priv {
 	struct rtl8xxxu_btcoex bt_coex;
 	struct rtl8xxxu_ra_report ra_report;
 	struct rtl8xxxu_cfo_tracking cfo_tracking;
-	struct rtl8xxxu_ra_info ra_info;
+	struct rtl8xxxu_ra_info ra_info[RTL8188E_MAX_MAC_ID_NUM];
=20
 	bool led_registered;
 	char led_name[32];
=2D-=20
2.53.0


