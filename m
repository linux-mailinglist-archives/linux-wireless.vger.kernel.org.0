Return-Path: <linux-wireless+bounces-18493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5BAA28637
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E003A6C3F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58C22A7E8;
	Wed,  5 Feb 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJbHmCxn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1A22A4FC
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746704; cv=none; b=P3eT1/uy3IqGLERCut1uZKg0oN5/YtxrE/n8w9wfCT7bUM0sjjq6zUUSSCUt1K8EqkNZmaTYfzpzZYMDAa0zbSLgnqYkE4/u9UqiJNO0YUhtevRPktCkieq9R4yVVcs0aDnp2ErqCPIV3Ax1Go7AVENYpwsIXbPsd75fCCDibLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746704; c=relaxed/simple;
	bh=2xGNb6+PYn+RV2OrORSkRXhEyCHxo+QWRjjxDrEtLX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LUnzGNKWOqIHYpj9IGo/lPBcs6n2uGhj0CAUTn4yqsCVj+mkcYsSAcTq+SM/CYD4gbZAnDzLIVmMPb6+2JUr6Y7R7V2ZYIsdADKlhfBcIDba8Tm6kkPBrJkwUPeuptiWtV0vms8LsVRWkIT8q05JMhyg0fh5esmPQBtkv7+IfoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iJbHmCxn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so64647885e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 01:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738746700; x=1739351500; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIUDjyBVwJ/dm7gTPgpVoztf+HTD2k5fIkdAtbxgAm0=;
        b=iJbHmCxn0m/PenQAGzBTmKLGiNl8Dfs57irkOd6+f/d0klUi7pbBB5IP1qHPcONXuL
         TuGtDqXfknwWJRANtqtgy6uv8YmfwmZ4VXb1ETMRQIaRrEJHmeHTaQfz8jiWbeULxPTl
         klKGaWisrVjRDOkPXo//cAb+182jt5u0chfM0pd0/jJu+DY5U+ZZ+JhOGLpqmDv7xs4j
         1KMXOz8FjfSoHZOSD2ncgy7sezaMLnIl/ohyr48TRqfK+XWHTZ5GXiI3726ghb+2qFJ6
         O09maMCCHn9AbWFhjTuOut63zPZQ28q6pgM3Fs8P899dxevTmzSkz8l0mTgKbZJdXltF
         6xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738746700; x=1739351500;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIUDjyBVwJ/dm7gTPgpVoztf+HTD2k5fIkdAtbxgAm0=;
        b=GzzSafqajZzo0sbcJDjWkBjxePmlZ4Nz6yk0fOABU/Yn7618Du0t7gr/IWuOixE0Kk
         YYBhP7UEhBoTvO7O0lOA4fbRhSE+KAGgPLJAvaIPNT+2819WG+su4Cy0eX2j4sr6Iez6
         5tK7kXGYGk3LUqVmZyCmQpkn13D8FezjzmVs5/rlnvt6QcWcKr7FbGZYvTeq5lAAX0GW
         u5ZlWsZVnV+jnXIk7Afn/nSioxM1t20OqC/dfpUG1Kgikce8z/Vtrh8uV4U1OS3qGR/H
         2Vu4EdNb+X8SD1Ot76xxA6NxOkqRFduK908bcEZf2fRB5UBOSh6m9fDRtIEB4+5fQKWa
         9GfA==
X-Forwarded-Encrypted: i=1; AJvYcCXojzgYGWD65qt/jLxXuhncDJ5xuk1672/gS35kEUawshMz89kg/8eLsf+eXEpjnzMI9DWN9Y4UgxbqbmLN0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyE4WK9XR7eXsJyxd+/DVdQKf2PXT9WX+fWIpOs2yfELzgB4GX
	jvA1EwYONcUY9Vpr9aIfokyyPwm1hI4cQquZpRWYjWqQpwJknQJyMAomFeFEF4g=
X-Gm-Gg: ASbGncsQ0JIuqM2uHqMLOB3gXVReh5cBSDJnj49C98BHCjnBZv8k9ZryJqNX8XYg4Sw
	4ldKHq9bnPVkEmhhG969lHvKe/BQTbTLywwQ+hjrUcjiH6eap2iwodhwp4ddvewkP2Hr6eWQTPT
	XLn/8OrFgOxo1qMJeTrdkMx1XeEKskpPYUnAe1rBbQaB2H7CgjgTZIVv8mGWsyvsMGhjnhH1NgV
	nqu9OLbtqKMehd7Mmw1Jo4yCuC5fUOaIwzx3mRwUIEiQ5RX2/1bDMcrROOxNUsIMZiRceYn26Nk
	M9SZddQ77YuuCWFbYmSy
X-Google-Smtp-Source: AGHT+IFIs1qAaUKAvLcYISJkN6uoUXlhr9ORlrTo5xO0VyHLR1PeFb7Tmmm2EQua0lntTf/Wmw/l4w==
X-Received: by 2002:a05:600c:1e02:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4390d43d465mr12605905e9.13.1738746700375;
        Wed, 05 Feb 2025 01:11:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dafeee4f6sm3249458f8f.60.2025.02.05.01.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 01:11:40 -0800 (PST)
Date: Wed, 5 Feb 2025 12:11:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [bug report] wcn36xx: Transition driver to SMD client
Message-ID: <8e85b9bf-8b4d-4926-8daa-f84608561383@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Bjorn Andersson,

Commit f303a9311065 ("wcn36xx: Transition driver to SMD client") from
Jan 11, 2017 (linux-next), leads to the following Smatch static
checker warning:

drivers/net/wireless/ath/wcn36xx/main.c:1616 wcn36xx_probe() warn: 'wcn->smd_channel' is not an error pointer
drivers/bluetooth/btqcomsmd.c:155 btqcomsmd_probe() warn: 'btq->acl_channel' is not an error pointer
drivers/bluetooth/btqcomsmd.c:160 btqcomsmd_probe() warn: 'btq->cmd_channel' is not an error pointer

drivers/net/wireless/ath/wcn36xx/main.c
    1557 static int wcn36xx_probe(struct platform_device *pdev)
    1558 {
    1559         struct ieee80211_hw *hw;
    1560         struct wcn36xx *wcn;
    1561         void *wcnss;
    1562         int ret;
    1563         const u8 *addr;
    1564         int n_channels;
    1565 
    1566         wcn36xx_dbg(WCN36XX_DBG_MAC, "platform probe\n");
    1567 
    1568         wcnss = dev_get_drvdata(pdev->dev.parent);
    1569 
    1570         hw = ieee80211_alloc_hw(sizeof(struct wcn36xx), &wcn36xx_ops);
    1571         if (!hw) {
    1572                 wcn36xx_err("failed to alloc hw\n");
    1573                 ret = -ENOMEM;
    1574                 goto out_err;
    1575         }
    1576         platform_set_drvdata(pdev, hw);
    1577         wcn = hw->priv;
    1578         wcn->hw = hw;
    1579         wcn->dev = &pdev->dev;
    1580         wcn->first_boot = true;
    1581         mutex_init(&wcn->conf_mutex);
    1582         mutex_init(&wcn->hal_mutex);
    1583         mutex_init(&wcn->scan_lock);
    1584         __skb_queue_head_init(&wcn->amsdu);
    1585 
    1586         wcn->hal_buf = devm_kmalloc(wcn->dev, WCN36XX_HAL_BUF_SIZE, GFP_KERNEL);
    1587         if (!wcn->hal_buf) {
    1588                 ret = -ENOMEM;
    1589                 goto out_wq;
    1590         }
    1591 
    1592         n_channels = wcn_band_2ghz.n_channels + wcn_band_5ghz.n_channels;
    1593         wcn->chan_survey = devm_kcalloc(wcn->dev,
    1594                                         n_channels,
    1595                                         sizeof(struct wcn36xx_chan_survey),
    1596                                         GFP_KERNEL);
    1597         if (!wcn->chan_survey) {
    1598                 ret = -ENOMEM;
    1599                 goto out_wq;
    1600         }
    1601 
    1602         ret = dma_set_mask_and_coherent(wcn->dev, DMA_BIT_MASK(32));
    1603         if (ret < 0) {
    1604                 wcn36xx_err("failed to set DMA mask: %d\n", ret);
    1605                 goto out_wq;
    1606         }
    1607 
    1608         wcn->nv_file = WLAN_NV_FILE;
    1609         ret = of_property_read_string(wcn->dev->parent->of_node, "firmware-name", &wcn->nv_file);
    1610         if (ret < 0 && ret != -EINVAL) {
    1611                 wcn36xx_err("failed to read \"firmware-name\" property: %d\n", ret);
    1612                 goto out_wq;
    1613         }
    1614 
    1615         wcn->smd_channel = qcom_wcnss_open_channel(wcnss, "WLAN_CTRL", wcn36xx_smd_rsp_process, hw);
--> 1616         if (IS_ERR(wcn->smd_channel)) {

qcom_wcnss_open_channel() only returns error pointers if
CONFIG_QCOM_WCNSS_CTRL is disabled.  I guess this is a COMPILE_TEST
thing?  Normally it would be the reverse way where functions return
error pointers on error for real errors and NULL for COMPILE_TEST of
if the feature is optional.

    1617                 wcn36xx_err("failed to open WLAN_CTRL channel\n");
    1618                 ret = PTR_ERR(wcn->smd_channel);
    1619                 goto out_wq;
    1620         }
    1621 
    1622         addr = of_get_property(pdev->dev.of_node, "local-mac-address", &ret);
    1623         if (addr && ret != ETH_ALEN) {
    1624                 wcn36xx_err("invalid local-mac-address\n");
    1625                 ret = -EINVAL;
    1626                 goto out_destroy_ept;
    1627         } else if (addr) {
    1628                 wcn36xx_info("mac address: %pM\n", addr);
    1629                 SET_IEEE80211_PERM_ADDR(wcn->hw, addr);
    1630         }
    1631 
    1632         ret = wcn36xx_platform_get_resources(wcn, pdev);
    1633         if (ret)
    1634                 goto out_destroy_ept;
    1635 
    1636         wcn36xx_init_ieee80211(wcn);
    1637         ret = ieee80211_register_hw(wcn->hw);
    1638         if (ret)
    1639                 goto out_unmap;
    1640 
    1641         return 0;
    1642 
    1643 out_unmap:
    1644         iounmap(wcn->ccu_base);
    1645         iounmap(wcn->dxe_base);
    1646 out_destroy_ept:
    1647         rpmsg_destroy_ept(wcn->smd_channel);
    1648 out_wq:
    1649         ieee80211_free_hw(hw);
    1650 out_err:
    1651         return ret;
    1652 }

regards,
dan carpenter

