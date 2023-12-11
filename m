Return-Path: <linux-wireless+bounces-667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472FD80CF4C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 16:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A501F21383
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33004AF65;
	Mon, 11 Dec 2023 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYpy3mKh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84444A9AE
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 15:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472CAC433C7;
	Mon, 11 Dec 2023 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702307903;
	bh=Sg9LH3dFc3PNlGjbWX6hAhLHhjdap8awuYbouxTP5OY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VYpy3mKhDmzToxUD0q7aDhAl5Fa0NQOou+v16Oi/Mu6gwGMYtl8h/xOGDf4emq4cA
	 AdxEojpCIUqtnQYJH6UexnwoDYJQ7si9eUs7Sj8msYnbZmMGcEXekwXri3zmlA70Ho
	 nFML4XAApHUhb/0s9/4TXgXuHur/0S2uwVKxGnxoGy6gfwLdw87PGXLLT0pU1XqC/C
	 NnsGjoinhU6pqLDGjuMafAZpR5qWnxIxiHccYUqsEqEszYgU/xGLOJ15fu+NA5Oiyh
	 1HhKgKBW0YawkeIID4FZmecNu7ZIpqcLjQ6wBOaKMb9TB33xfkSY+aCAe9zaSPJEL4
	 Kkv/1W2grEPZg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Aditya Kumar Singh <quic_adisi@quicinc.com>,
  <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v8 02/12] wifi: ath11k: store cur_regulatory_info for
 each radio
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
	<20231204081323.5582-3-quic_bqiang@quicinc.com>
	<db8b0734-8e4e-43f9-ba48-b3df2d33e29e@quicinc.com>
	<2c70dfd6-9e0e-468b-8585-252f0c23ff0a@quicinc.com>
Date: Mon, 11 Dec 2023 17:18:19 +0200
In-Reply-To: <2c70dfd6-9e0e-468b-8585-252f0c23ff0a@quicinc.com> (Baochen
	Qiang's message of "Mon, 11 Dec 2023 11:56:52 +0800")
Message-ID: <871qbs6a4k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 12/7/2023 11:15 AM, Aditya Kumar Singh wrote:
>> On 12/4/23 13:43, Baochen Qiang wrote:
>>> --- a/drivers/net/wireless/ath/ath11k/mac.h
>>> +++ b/drivers/net/wireless/ath/ath11k/mac.h
>>> @@ -159,7 +159,6 @@ struct ath11k_vif *ath11k_mac_get_vif_up(struct
>>> ath11k_base *ab);
>>> =C2=A0 struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base
>>> *ab, u32 vdev_id);
>>> =C2=A0 struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base
>>> *ab, u32 pdev_id);
>>> -
>> Irrelevant change w.r.t commit message?
>>=20
>>> =C2=A0 void ath11k_mac_drain_tx(struct ath11k *ar);
>>> =C2=A0 void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
>>> =C2=A0 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void =
*ctx);
>> ...
>>> @@ -4749,6 +4749,11 @@ static int
>>> ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soc->pdevs[0].pd=
ev_id =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!soc->reg_info_store)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soc->reg_info_store =3D kca=
lloc(soc->num_radios,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sizeof(*soc->reg_info_store),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 GFP_ATOMIC);
>> What if this memory allocation request fails? Any negative case
>> check should be present?
>>=20
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> @@ -7071,33 +7076,54 @@ static bool ath11k_reg_is_world_alpha(char
>>> *alpha)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0 }
>>> -static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *s=
kb,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum wmi_reg_chan=
_list_cmd_type id)
>>> +void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 struct cur_regulatory_info *reg_info =3D NULL;
>>> -=C2=A0=C2=A0=C2=A0 struct ieee80211_regdomain *regd =3D NULL;
>>> -=C2=A0=C2=A0=C2=A0 bool intersect =3D false;
>>> -=C2=A0=C2=A0=C2=A0 int ret =3D 0, pdev_idx, i, j;
>>> -=C2=A0=C2=A0=C2=A0 struct ath11k *ar;
>>> +=C2=A0=C2=A0=C2=A0 int i, j;
>>> -=C2=A0=C2=A0=C2=A0 reg_info =3D kzalloc(sizeof(*reg_info), GFP_ATOMIC);
>>> -=C2=A0=C2=A0=C2=A0 if (!reg_info) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fallback;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (reg_info) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(reg_info->reg_rules_2=
ghz_ptr);
>>> -=C2=A0=C2=A0=C2=A0 if (id =3D=3D WMI_REG_CHAN_LIST_CC_ID)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ath11k_pull_reg_cha=
n_list_update_ev(ab, skb, reg_info);
>>> -=C2=A0=C2=A0=C2=A0 else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ath11k_pull_reg_cha=
n_list_ext_update_ev(ab, skb,
>>> reg_info);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(reg_info->reg_rules_5=
ghz_ptr);
>>> -=C2=A0=C2=A0=C2=A0 if (ret) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ath11k_warn(ab, "failed to =
extract regulatory info from
>>> received event\n");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fallback;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < WMI_REG_C=
URRENT_MAX_AP_TYPE; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfr=
ee(reg_info->reg_rules_6ghz_ap_ptr[i]);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for=
 (j =3D 0; j < WMI_REG_MAX_CLIENT_TYPE; j++)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 kfree(reg_info->reg_rules_6ghz_client_ptr[i][j]);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(reg_info, 0, sizeof(=
*reg_info));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static
>>> +enum wmi_vdev_type ath11k_reg_get_ar_vdev_type(struct ath11k *ar)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ath11k_vif *arvif;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Currently each struct ath11k maps to one struct
>>> ieee80211_hw/wiphy
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * and one struct ieee80211_regdomain, so it c=
ould only store
>>> one group
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reg rules. It means muti-interface concurre=
ncy in the same
>>> ath11k is
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * not support for the regdomain. So get the v=
dev type of the
>>> first entry
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * now. After concurrency support for the regd=
omain, this
>>> should change.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 arvif =3D list_first_entry_or_null(&ar->arvifs, str=
uct
>>> ath11k_vif, list);
>>> +=C2=A0=C2=A0=C2=A0 if (arvif)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return arvif->vdev_type;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return WMI_VDEV_TYPE_UNSPEC;
>>> +}
>>> +
>>> +int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct cur_regulatory_info *reg_info,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enum ieee80211_ap_reg_power power_type)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct ieee80211_regdomain *regd;
>>> +=C2=A0=C2=A0=C2=A0 bool intersect =3D false;
>>> +=C2=A0=C2=A0=C2=A0 int pdev_idx;
>>> +=C2=A0=C2=A0=C2=A0 struct ath11k *ar;
>>> +=C2=A0=C2=A0=C2=A0 enum wmi_vdev_type vdev_type;
>>> -=C2=A0=C2=A0=C2=A0 ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg chan list=
 id %d", id);
>>> +=C2=A0=C2=A0=C2=A0 ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg handle ch=
an list");
>> I believe this debug was helpful in the sense it showed which type
>> of event came. Can't we still print this somehow? Or may be
>> somewhere else?You can check the event type from logs of=20
> ath11k_pull_reg_chan_list_update_ev() and
> ath11k_pull_reg_chan_list_ext_update_ev().

Baochen, I didn't see any comments from you. Did you send an empty mail
by accident?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

