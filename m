Return-Path: <linux-wireless+bounces-20251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4BBA5E0BD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 16:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DEF3A5F58
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B750F253B47;
	Wed, 12 Mar 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BD82QXbJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEEB252906;
	Wed, 12 Mar 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794150; cv=none; b=KMhNx4TjYfJznXEfTqjMPlHKDyJH5qB4XeCygOAGGt9aGeZU1hYUQXju5Tk1+9zZYJRcpoMNCrfjDf3jC+qelkivJc/Kb9C9NWYGwSJ65jWDr5toCJgRErtXW6PYEa//BqHvPEpbFZLQQKWzvgm236mYw/NFwzY4OFY6/Q8zOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794150; c=relaxed/simple;
	bh=TPokZkAfZoE3j1ReraRUjF3yXEY6rHEC7KL8G+9L1lw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tnsGhpUZiXAYllHYhNtm4zMONIeAdM+KLh0/q+H4i+nYPfwYxV8n/UZwwxWM6We1Z7qBVKHNslqCZdTcQiGYGiuGChE6lS4e3xHp6XJ6otekrBMCgkfvXyNxkkK6In6xmt8IoBKQ228l++Er0eE/Gxb4dFMkAJGsmXn5RIgM8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BD82QXbJ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741794142; x=1742398942; i=markus.elfring@web.de;
	bh=WaZqZA26uQBOohPg9do+Xiwkxafj6Jb1roW9F5p+eoE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BD82QXbJxi0fCDcWS37HOPkwr/iWAfhVZqV526dK2+uABCh3Z+ghcf/1Eeq3hHaj
	 l6MKsPWzIOepMZtK++I20m5JjOCMvC5NGmtVssX8c8MnOZqzhIDyiPSIueZ0zTLOy
	 1YTmEGO2MB5i+MxW2u10zkNy95Y4M86ttRfOYK+KhJfOxFg7mf7Isn6uNWi3+5uPh
	 7F0Ow9a+dWxSAAI7teMQgV5Z3OfCgrIuRKz1aGL1jpzyNVGAx+FBj4m9lRO9zFUdw
	 UCrLReO1KfKzdWP6CpAfDfCK2IqMUIkkD2+9dWsofPinitDEgOLArZKxuGtjmFcAU
	 1S1kMSSnf8IYbIXGuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgT9-1tUHcT1EQl-00iXt9; Wed, 12
 Mar 2025 16:42:22 +0100
Message-ID: <1b32cd5b-aa46-4a23-bd21-908196c4bab3@web.de>
Date: Wed, 12 Mar 2025 16:42:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>, linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
 Avraham Stern <avraham.stern@intel.com>,
 Daniel Gabay <daniel.gabay@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>
References: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
Subject: Re: [PATCH] wifi: iwlwifi: Fix uninitialized variable with __free()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZKn6UwdQ7UztrBsRGLjm+ca4mdIDBz6ZIt6nxP7D4JggU3nZlzw
 UEQUN/Wj98FPk9MV1N9kULAR77SHX9ppJEXhBTOTcs2xezzOtuXvKVQuFj0UMbXBMhLAtT3
 zQCc7BA4LdNpJaRa3mNWIXUU4GMzZezlcI5XVOxIqlvh9jzJ051Y/58SSUE1UlBRrOXcdbB
 mXComGHHd91yq/BSF8T4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4YdC1FvAU2s=;FfUd+3nLn4V2x+hw2Q7N77b+awZ
 oog8iL0es+oX3MNBLgTbwYYcFf0XOXqYpBvFPQAbNO/PUm0yFgN9emfUPeSWjDTBXFSisLRXU
 Rmi/wm2xIqkhu8TCYug/Cd9+PIRrqi+1c6jiibiK2I6qQp5vcDxm+24AbF/N343PfzFtLAB9j
 8dpYlJknJTuPV/bOi+oHJA2x0m4KVpJ9GxTxCYyj6BtP3SDQxzmJHZDd9gp9BfQoHyQbs6L20
 ovgx+UQIL6Rv3baHvDFGOsJkp+GsebwJ3zrZBr5tdef7kidb/b1slgIdr2AcP7ph1bcCPgagg
 CNFCegveB+dsNrdOIy3rlmNPOaWHlvazILo8d1jALg2D4pRyLoBH0PdagjTelpVuPn9L8Gblp
 69fEeX8e0Fg8Zjpjjt/CxQJhTXzWTqetJwCu0+j6adpBe+hT6oz5Djn96CU7QPs5jdzE6kHWQ
 qexiJ9enWNfhVpMlKmfhUITPw8ny9zWHJo2bizUFLOIWrquK/aK/t0VW5JU3XDteFYQMXU+wP
 ZAHsBKqP4PT7Ra9KBS11sstqvMX0TY9McquNsaTZsNSPaU27B8scKqB7dL/3TYAamLGlkhsiv
 EhGv3ABeioWpmtyYLYBkbhH8h4aomKJd01WOHtFE5DraraxXYdwX3kLvDf1Tc3YgxeSf62ie3
 Y28onvGP+jVITvNk729NUDl7xf6peKmfua+tOdBrHS4kGXgNLcqwP3JB0Q7SPNdy5faMWfTKw
 BF+wRiVuBCQQgtxYhvkk+cWEjMQdxaBAuvEPRRXPf2SMyAI8adZPpdUoC3tVUr287jN3Spn9U
 STWSfunnZZETWeb7JrjZ3ZGt74rWV3MBjOqpZQZCPB1LMSYLOwIDlWsqR2bJ/begwGPBeKH59
 E5uiQdrLkcwtUHB+VvnH0rk0lagq3vU8zBkRyA26U80/aO//NV+tP/37JOkGZo7RRnsuem7ZG
 laM1u3ZIUixD5aCFgTm40JFkXVlZGREWimIs9Gpc2XqoOZONH7whnpxjueyl03/BPPELG5Y4d
 Ly1NGqSoQlBjvKgowph59KcWDRCZAsDrM+gTiNcLw4WD6ZM4/yzJ3iQKHtIn/Xy/IHdhVm6ZJ
 ONvcn5GzyGD8JydBWSrJWe4YwZ21hotuVq0/FONsDs2O4/wyXHZSZhtIhV7Y2beP88KkJTJPp
 ApZNymzCZ+vXy9aX6efTKZWMHaP6eyFa0V4nAMFfgYHRKZmC3PaNtac2H9hJ0C1GgSQBhLoHR
 YZDwQG06m9DY6ioEwq/k86owLvy72ffQztiy6VNw87dI8ypaqootCxyr8pHrTtXdNJtvojugD
 ++7ncx2Xaw+n4MgDEkHjpm9FtrpNmXEhlfnAPOUlf7kDzA8B1k7Yzwgiyowx837F+ntMSuoRs
 pbKaFLU0Nv13tkRh2oo1r+ORfz0zCJBKbTvzJglJinjxmbo42jht0YCuOmC4T3/XZrOvVvTQG
 ilfvNv0yp+VvEGi0ct6qqGfjdrAhksbYB93fV8W1ggR0uwNyT

=E2=80=A6
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
> @@ -556,8 +556,8 @@ iwl_dbgfs_vif_twt_setup_write(struct iwl_mld *mld, c=
har *buf, size_t count,
>  	};
>  	struct ieee80211_vif *vif =3D data;
>  	struct iwl_mld_vif *mld_vif =3D iwl_mld_vif_from_mac80211(vif);
> +	struct iwl_dhc_cmd *cmd __free(kfree) =3D NULL;
>  	struct iwl_dhc_twt_operation *dhc_twt_cmd;
> -	struct iwl_dhc_cmd *cmd __free(kfree);
=E2=80=A6

Can it be recommended to reduce the scope for the affected local variable =
instead?
https://elixir.bootlin.com/linux/v6.14-rc6/source/include/linux/cleanup.h#=
L129-L133

Regards,
Markus

