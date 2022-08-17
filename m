Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292BE596A1D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 09:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiHQHMK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiHQHMJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 03:12:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553955A2C1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 00:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC3BBB81BEC
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 07:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA68C433D6;
        Wed, 17 Aug 2022 07:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660720324;
        bh=2NmpIxUgur58QWaJmK3iQ/1Unat3K1qzU/kM9ugYgG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Icn/o40mw2hC1CeAjt7nmXgKLhwOj1vDdtK2mLwHeNTzizbzJdc11MamAk4uN2jo6
         TTHzsOim6I1nrtl0JY3n9xaHKhFiLM7XFhi71n3vnDOl//kP0MX4jV7Bll9qawxgL+
         8mzaoJBjbIEJMTU0tC9eAGJhlajZSFjOR8VYOGblwvjdWcNHwVE/jBqOOHMhG0Nyzb
         9fqe9kppA2xxLurQyP7TrfjE9vCurCkSP5PhYtIS8BZWbV4et+l391d0eQCR6+e2zC
         5gXfKnOeyzXWXeyOtyMBs8DwYNWyxxc2Abrn3WSoKX3Aqu0mJibMViNG24ItSzAFWk
         vR9b5fizkjfQA==
Date:   Wed, 17 Aug 2022 09:12:00 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 8/9] wifi: mt76: mt7921: introduce remain_on_channel
 support
Message-ID: <YvyUwEdURYHiAduf@lore-desk>
References: <cover.1660606893.git.objelf@gmail.com>
 <f48a750e8ad17d5b2410eea03fc30a6403732168.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UW9AtAPt/ai69Lh1"
Content-Disposition: inline
In-Reply-To: <f48a750e8ad17d5b2410eea03fc30a6403732168.1660606893.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--UW9AtAPt/ai69Lh1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Introduce remain_on_channel support. Additionally, we add
> mt7921_check_offload_capability to disable .remain_on_channel and
> .cancel_remain_on_channel and related configuration because those
> operations would rely on the fundamental MCU commands that will be only
> supported with newer firmware.
>=20
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/init.c  |  36 ++++++
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 112 ++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  24 ++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  34 ++++++
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  13 +-
>  .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  11 +-
>  .../net/wireless/mediatek/mt76/mt7921/usb.c   |   1 +
>  7 files changed, 225 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index cd960e23770f..1b7a18d42f5b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -44,6 +44,35 @@ mt7921_regd_notifier(struct wiphy *wiphy,
>  	mt7921_mutex_release(dev);
>  }
> =20
> +static int mt7921_check_offload_capability(struct mt7921_dev *dev)
> +{
> +	struct ieee80211_hw *hw =3D mt76_hw(dev);
> +	int year, mon, day, hour, min, sec;
> +	struct wiphy *wiphy =3D hw->wiphy;
> +	bool fw_can_roc =3D false;
> +	int ret;
> +
> +	ret =3D sscanf(dev->mt76.hw->wiphy->fw_version + 11, "%4d%2d%2d%2d%2d%2=
d",
> +		     &year, &mon, &day, &hour, &min, &sec);

does the fw have a differnt base version with respect to the previous ones?
checking the date is a bit ugly.

> +	if (ret !=3D 6)
> +		goto out;
> +
> +	/* Old firmware cannot support remained on channel and channel
> +	 * context management.
> +	 */
> +	fw_can_roc =3D  mktime64(year, mon, day, hour, min, sec) >=3D
> +		      mktime64(2022, 7, 15, 12, 1, 1);
> +out:
> +	if (!fw_can_roc) {
> +		dev->ops->remain_on_channel =3D NULL;
> +		dev->ops->cancel_remain_on_channel =3D NULL;
> +
> +		wiphy->flags &=3D ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  mt7921_init_wiphy(struct ieee80211_hw *hw)
>  {
> @@ -70,6 +99,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
>  	wiphy->interface_modes =3D BIT(NL80211_IFTYPE_STATION) |
>  				 BIT(NL80211_IFTYPE_AP);
>  	wiphy->n_iface_combinations =3D ARRAY_SIZE(if_comb);
> +	wiphy->max_remain_on_channel_duration =3D 5000;
>  	wiphy->max_scan_ie_len =3D MT76_CONNAC_SCAN_IE_LEN;
>  	wiphy->max_scan_ssids =3D 4;
>  	wiphy->max_sched_scan_plan_interval =3D
> @@ -79,6 +109,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
>  	wiphy->max_match_sets =3D MT76_CONNAC_MAX_SCAN_MATCH;
>  	wiphy->max_sched_scan_reqs =3D 1;
>  	wiphy->flags |=3D WIPHY_FLAG_HAS_CHANNEL_SWITCH;
> +	wiphy->flags |=3D WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
>  	wiphy->reg_notifier =3D mt7921_regd_notifier;
> =20
>  	wiphy->features |=3D NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
> @@ -222,6 +253,7 @@ static void mt7921_init_work(struct work_struct *work)
>  	if (ret)
>  		return;
> =20
> +	mt7921_check_offload_capability(dev);
>  	mt76_set_stream_caps(&dev->mphy, true);
>  	mt7921_set_stream_he_caps(&dev->phy);
> =20
> @@ -277,6 +309,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
>  	INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
>  	INIT_WORK(&dev->init_work, mt7921_init_work);
> =20
> +	INIT_WORK(&dev->phy.roc_work, mt7921_roc_work);
> +	timer_setup(&dev->phy.roc_timer, mt7921_roc_timer, 0);
> +	init_waitqueue_head(&dev->phy.roc_wait);
> +
>  	dev->pm.idle_timeout =3D MT7921_PM_TIMEOUT;
>  	dev->pm.stats.last_wake_event =3D jiffies;
>  	dev->pm.stats.last_doze_event =3D jiffies;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index b280f184244f..ae0aabe052e3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -386,6 +386,116 @@ static void mt7921_remove_interface(struct ieee8021=
1_hw *hw,
>  	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
>  }
> =20
> +static void mt7921_roc_iter(void *priv, u8 *mac,
> +			    struct ieee80211_vif *vif)
> +{
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +	struct mt7921_phy *phy =3D priv;
> +
> +	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
> +}
> +
> +void mt7921_roc_work(struct work_struct *work)
> +{
> +	struct mt7921_phy *phy;
> +
> +	phy =3D (struct mt7921_phy *)container_of(work, struct mt7921_phy,
> +						roc_work);
> +
> +	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> +		return;
> +
> +	mt7921_mutex_acquire(phy->dev);
> +	ieee80211_iterate_active_interfaces(phy->mt76->hw,
> +					    IEEE80211_IFACE_ITER_RESUME_ALL,
> +					    mt7921_roc_iter, phy);
> +	mt7921_mutex_release(phy->dev);
> +	ieee80211_remain_on_channel_expired(phy->mt76->hw);
> +}
> +
> +void mt7921_roc_timer(struct timer_list *timer)
> +{
> +	struct mt7921_phy *phy =3D from_timer(phy, timer, roc_timer);
> +
> +	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
> +}
> +
> +static int mt7921_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *v=
if)
> +{
> +	int err;
> +
> +	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> +		return 0;
> +
> +	del_timer_sync(&phy->roc_timer);
> +	cancel_work_sync(&phy->roc_work);
> +	err =3D mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
> +	clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> +
> +	return 00;
> +}
> +
> +static int mt7921_set_roc(struct mt7921_phy *phy,
> +			  struct mt7921_vif *vif,
> +			  struct ieee80211_channel *chan,
> +			  int duration,
> +			  enum mt7921_roc_req type)
> +{
> +	int err;
> +
> +	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
> +		return -EBUSY;
> +
> +	phy->roc_grant =3D false;
> +
> +	err =3D mt7921_mcu_set_roc(phy, vif, chan, duration, type,
> +				 ++phy->roc_token_id);
> +	if (err < 0) {
> +		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> +		goto out;
> +	}
> +
> +	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, HZ)) {
> +		mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
> +		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> +		err =3D -ETIMEDOUT;
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +static int mt7921_remain_on_channel(struct ieee80211_hw *hw,
> +				    struct ieee80211_vif *vif,
> +				    struct ieee80211_channel *chan,
> +				    int duration,
> +				    enum ieee80211_roc_type type)
> +{
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +	struct mt7921_phy *phy =3D mt7921_hw_phy(hw);
> +	int err;
> +
> +	mt7921_mutex_acquire(phy->dev);
> +	err =3D mt7921_set_roc(phy, mvif, chan, duration, MT7921_ROC_REQ_ROC);
> +	mt7921_mutex_release(phy->dev);
> +
> +	return err;
> +}
> +
> +static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
> +					   struct ieee80211_vif *vif)
> +{
> +	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
> +	struct mt7921_phy *phy =3D mt7921_hw_phy(hw);
> +	int err;
> +
> +	mt7921_mutex_acquire(phy->dev);
> +	err =3D mt7921_abort_roc(phy, mvif);
> +	mt7921_mutex_release(phy->dev);
> +
> +	return err;
> +}
> +
>  static int mt7921_set_channel(struct mt7921_phy *phy)
>  {
>  	struct mt7921_dev *dev =3D phy->dev;
> @@ -1618,6 +1728,8 @@ const struct ieee80211_ops mt7921_ops =3D {
>  #endif /* CONFIG_PM */
>  	.flush =3D mt7921_flush,
>  	.set_sar_specs =3D mt7921_set_sar_specs,
> +	.remain_on_channel =3D mt7921_remain_on_channel,
> +	.cancel_remain_on_channel =3D mt7921_cancel_remain_on_channel,
>  };
>  EXPORT_SYMBOL_GPL(mt7921_ops);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 05b625e02265..529fb56323ef 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -127,6 +127,29 @@ void mt7921_mcu_set_suspend_iter(void *priv, u8 *mac=
, struct ieee80211_vif *vif)
> =20
>  #endif /* CONFIG_PM */
> =20
> +static void
> +mt7921_mcu_uni_roc_event(struct mt7921_dev *dev, struct sk_buff *skb)
> +{
> +	struct mt7921_roc_grant_tlv *grant;
> +	struct mt76_connac2_mcu_rxd *rxd;
> +	int duration;
> +
> +	rxd =3D (struct mt76_connac2_mcu_rxd *)skb->data;
> +	grant =3D (struct mt7921_roc_grant_tlv *)(rxd->tlv + 4);
> +
> +	/* should never happen */
> +	WARN_ON_ONCE((le16_to_cpu(grant->tag) !=3D UNI_EVENT_ROC_GRANT));
> +
> +	if (grant->reqtype =3D=3D MT7921_ROC_REQ_ROC)
> +		ieee80211_ready_on_channel(dev->mt76.phy.hw);
> +
> +	dev->phy.roc_grant =3D true;
> +	wake_up(&dev->phy.roc_wait);
> +	duration =3D le32_to_cpu(grant->max_interval);
> +	mod_timer(&dev->phy.roc_timer,
> +		  round_jiffies_up(jiffies + msecs_to_jiffies(duration)));
> +}
> +
>  static void
>  mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
>  {
> @@ -283,6 +306,7 @@ mt7921_mcu_uni_rx_unsolicited_event(struct mt7921_dev=
 *dev,
> =20
>  	switch (rxd->eid) {
>  	case MCU_UNI_EVENT_ROC:
> +		mt7921_mcu_uni_roc_event(dev, skb);
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index c9044d546e94..280605ffc4da 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -65,6 +65,30 @@ enum mt7921_roc_req {
>  	MT7921_ROC_REQ_NUM
>  };
> =20
> +enum {
> +	UNI_EVENT_ROC_GRANT =3D 0,
> +	UNI_EVENT_ROC_TAG_NUM
> +};
> +
> +struct mt7921_roc_grant_tlv {
> +	__le16 tag;
> +	__le16 len;
> +	u8 bss_idx;
> +	u8 tokenid;
> +	u8 status;
> +	u8 primarychannel;
> +	u8 rfsco;
> +	u8 rfband;
> +	u8 channelwidth;
> +	u8 centerfreqseg1;
> +	u8 centerfreqseg2;
> +	u8 reqtype;
> +	u8 dbdcband;
> +	u8 rsv[1];
> +	__le32 max_interval;
> +} __packed;
> +/* cnm end */
> +
>  enum mt7921_sdio_pkt_type {
>  	MT7921_SDIO_TXD,
>  	MT7921_SDIO_DATA,
> @@ -185,9 +209,16 @@ struct mt7921_phy {
> =20
>  	struct sk_buff_head scan_event_list;
>  	struct delayed_work scan_work;
> +
>  #ifdef CONFIG_ACPI
>  	struct mt7921_acpi_sar *acpisar;
>  #endif
> +
> +	struct work_struct roc_work;
> +	struct timer_list roc_timer;
> +	wait_queue_head_t roc_wait;
> +	u8 roc_token_id;
> +	bool roc_grant;
>  };
> =20
>  #define mt7921_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
> @@ -228,6 +259,7 @@ struct mt7921_dev {
>  	struct mt76_connac_pm pm;
>  	struct mt76_connac_coredump coredump;
>  	const struct mt7921_hif_ops *hif_ops;
> +	struct ieee80211_ops *ops;
> =20
>  	struct work_struct ipv6_ns_work;
>  	/* IPv6 addresses for WoWLAN */
> @@ -412,6 +444,8 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
>  			 struct ieee80211_ampdu_params *params,
>  			 bool enable);
>  void mt7921_scan_work(struct work_struct *work);
> +void mt7921_roc_work(struct work_struct *work);
> +void mt7921_roc_timer(struct timer_list *timer);
>  int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *=
vif);
>  int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
>  int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 9d1ba838e54f..0692fb0f91ca 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -252,6 +252,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  	};
> =20
>  	struct mt76_bus_ops *bus_ops;
> +	struct ieee80211_ops *ops;
>  	struct mt7921_dev *dev;
>  	struct mt76_dev *mdev;
>  	int ret;
> @@ -277,8 +278,14 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  	if (mt7921_disable_aspm)
>  		mt76_pci_disable_aspm(pdev);
> =20
> -	mdev =3D mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
> -				 &drv_ops);
> +	ops =3D devm_kmemdup(&pdev->dev, &mt7921_ops, sizeof(mt7921_ops),
> +			   GFP_KERNEL);

why do we need to copy mt7921_ops?

Regards,
Lorenzo

> +	if (!ops) {
> +		ret =3D -ENOMEM;
> +		goto err_free_pci_vec;
> +	}
> +
> +	mdev =3D mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
>  	if (!mdev) {
>  		ret =3D -ENOMEM;
>  		goto err_free_pci_vec;
> @@ -286,7 +293,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
> =20
>  	dev =3D container_of(mdev, struct mt7921_dev, mt76);
>  	dev->hif_ops =3D &mt7921_pcie_ops;
> -
> +	dev->ops =3D ops;
>  	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
>  	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/sdio.c
> index 487acd6e2be8..6d27875f41b8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> @@ -120,18 +120,23 @@ static int mt7921s_probe(struct sdio_func *func,
>  		.fw_own =3D mt7921s_mcu_fw_pmctrl,
>  	};
> =20
> +	struct ieee80211_ops *ops;
>  	struct mt7921_dev *dev;
>  	struct mt76_dev *mdev;
>  	int ret;
> =20
> -	mdev =3D mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
> -				 &drv_ops);
> +	ops =3D devm_kmemdup(&func->dev, &mt7921_ops, sizeof(mt7921_ops),
> +			   GFP_KERNEL);
> +	if (!ops)
> +		return -ENOMEM;
> +
> +	mdev =3D mt76_alloc_device(&func->dev, sizeof(*dev), ops, &drv_ops);
>  	if (!mdev)
>  		return -ENOMEM;
> =20
>  	dev =3D container_of(mdev, struct mt7921_dev, mt76);
>  	dev->hif_ops =3D &mt7921_sdio_ops;
> -
> +	dev->ops =3D ops;
>  	sdio_set_drvdata(func, dev);
> =20
>  	ret =3D mt76s_init(mdev, func, &mt7921s_ops);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/usb.c
> index d06cee386acd..cf3ec59a4270 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> @@ -217,6 +217,7 @@ static int mt7921u_probe(struct usb_interface *usb_in=
tf,
> =20
>  	dev =3D container_of(mdev, struct mt7921_dev, mt76);
>  	dev->hif_ops =3D &hif_ops;
> +	dev->ops =3D ops;
> =20
>  	udev =3D usb_get_dev(udev);
>  	usb_reset_device(udev);
> --=20
> 2.25.1
>=20

--UW9AtAPt/ai69Lh1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYvyUwAAKCRA6cBh0uS2t
rLwLAQCIcp3cJJVEg1ylg5LfydA4VhjL+Fm2zCmGgLSL34XTngD/bjSkE0ewjCvm
ZqBwV6jNLi+bdg2KuY1amGdE5VAtFQs=
=XHFZ
-----END PGP SIGNATURE-----

--UW9AtAPt/ai69Lh1--
