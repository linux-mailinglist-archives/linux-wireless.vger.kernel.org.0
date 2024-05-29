Return-Path: <linux-wireless+bounces-8264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB98D3955
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219701C20AAF
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98CB159214;
	Wed, 29 May 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2VJCtqX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F9159205
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993181; cv=none; b=eoQHWn+zjDw5LhqhJ+nZMW6bdBExbkxl1xXNyAB/wu2Z0UGZdA0SvDNCLwvcqpT3M3fvX1R1D6k5PVs92VXIlm5ToOCaaZPekjdRxoe0ZXAFCwdH8RXHpzc4RMKrSgfbJ3znbPdZ4A9BAwQQjsHSIiJ/1GF6b2CUTvK2ShQ7DwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993181; c=relaxed/simple;
	bh=flEvuhty6EuomG8EUxyF6Lx0gz0ZryAvEOoqeWjjf4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VlCMBq85Xo6ovO8+BnpwQKxphGVD+z8fHx2B7gCIAicMsKIYdpkZesKFhFH1QIrxOtFGAoHHa816zWZI20uSsEWSqf8I+NCSkOMedaJ4K/42xC8q2DyYiGmMIZstjVNzFsUi8QH2HhPepEmkkKFPzsoxp6CQ7TEKNZB3K1egR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H2VJCtqX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6266ffdba8so217836266b.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716993179; x=1717597979; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yGgtANfHFObW2yk4b9MyUemICbrjWPAQ6FaTZw/zLY=;
        b=H2VJCtqXtJlFLgVYByLy1TKuIM5m9lVD6jJJWZ7KHZJV+Do8KnGBA5///YGAkHWRj0
         T7Oglc518mPEPS+fqZrKqTFsMDxHtfjrvB8gX4m8VA7wBxhV+8luJgqHASzyJVohXFRn
         QJWhjiVBs/KXjP7NBhX032LMRBH5+NOT3lzmRJeGjArTaOonu2e0jdzfnoI/8vfCDQDN
         U9EnhEtPCeVOgNHlsNP4NP6Z3hA1xAEIYUzQnU9zZlL7awLXty1SbBWnDLDcoZUg+Lba
         TBNGYYr3FtDREi7ckeNrXPmiWOzZLYbPTTiWuOIQkkZp6fAqJAmZ81m3YVK7CH5pCsHd
         sKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993179; x=1717597979;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yGgtANfHFObW2yk4b9MyUemICbrjWPAQ6FaTZw/zLY=;
        b=GRuygFb85lYjPsOFSz6VeikWSuOrEwDZN3mXTXw2qtmT1RhYMCq8RrFt09EXAdWgQ3
         YINqgTnApRWVOZKxpERHerxtUwht0XNCwDqfDUamKg4XeOKfSMbnI5j74iUYYUNdS2kc
         z8Pop5bfR2dqiGffT5kFulfNuugTY3aoSKKLBJnqglKzVsc17tgvlHA4z+/eTAx7MDA1
         xiHQwQtVJr5P7UZFyy4z/q0xuqqHPZ3vv94LtHFwTK5Y7IZ847d4wzmZ7EzYdbqE8obc
         LUeMiAMe7r9k9lWAt/8uCX5dj0EeT52YKT53zTSP9IppnHY+K3/QDSWlEEcG2VwHnDBz
         JNlw==
X-Gm-Message-State: AOJu0YyLysx75YKQvyzIEzjGXaMUeZ/x7XG67oEM0lI3UM4Nf7Pkzvvn
	0ARm+E2sMJvU5EQUlHb8Fyw32YzgULybToqtkxuf4d1NNwgTXZUVdrlc1oFhyQI=
X-Google-Smtp-Source: AGHT+IFH7NS4aP8VmsnC+fzp4RqQSZye8zxVrfpr0Vj3x+zX4noEPHlGmYGdZ5clSANww20gpSAW2g==
X-Received: by 2002:a17:906:f5a6:b0:a62:de57:adbb with SMTP id a640c23a62f3a-a62de57b397mr969367866b.27.1716993178505;
        Wed, 29 May 2024 07:32:58 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c81734csm719589266b.45.2024.05.29.07.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:32:56 -0700 (PDT)
Date: Wed, 29 May 2024 17:32:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [bug report] wifi: ath11k: add P2P IE in beacon template
Message-ID: <2d277abd-5e7b-4da0-80e0-52bd96337f6e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kang Yang,

Commit 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
from Feb 28, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/wireless/ath/ath11k/wmi.c:1742 ath11k_wmi_p2p_go_bcn_ie()
	warn: sleeping in atomic context

drivers/net/wireless/ath/ath11k/wmi.c
    1712 int ath11k_wmi_p2p_go_bcn_ie(struct ath11k *ar, u32 vdev_id,
    1713                              const u8 *p2p_ie)
    1714 {
    1715         struct ath11k_pdev_wmi *wmi = ar->wmi;
    1716         struct wmi_p2p_go_set_beacon_ie_cmd *cmd;
    1717         size_t p2p_ie_len, aligned_len;
    1718         struct wmi_tlv *tlv;
    1719         struct sk_buff *skb;
    1720         int ret, len;
    1721 
    1722         p2p_ie_len = p2p_ie[1] + 2;
    1723         aligned_len = roundup(p2p_ie_len, 4);
    1724 
    1725         len = sizeof(*cmd) + TLV_HDR_SIZE + aligned_len;
    1726 
    1727         skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
    1728         if (!skb)
    1729                 return -ENOMEM;
    1730 
    1731         cmd = (struct wmi_p2p_go_set_beacon_ie_cmd *)skb->data;
    1732         cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_P2P_GO_SET_BEACON_IE) |
    1733                           FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
    1734         cmd->vdev_id = vdev_id;
    1735         cmd->ie_buf_len = p2p_ie_len;
    1736 
    1737         tlv = (struct wmi_tlv *)cmd->tlv;
    1738         tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
    1739                       FIELD_PREP(WMI_TLV_LEN, aligned_len);
    1740         memcpy(tlv->value, p2p_ie, p2p_ie_len);
    1741 
--> 1742         ret = ath11k_wmi_cmd_send(wmi, skb, WMI_P2P_GO_SET_BEACON_IE);
                       ^^^^^^^^^^^^^^^^^^^
This is a might_sleep() function.

    1743         if (ret) {
    1744                 ath11k_warn(ar->ab, "failed to send WMI_P2P_GO_SET_BEACON_IE\n");
    1745                 dev_kfree_skb(skb);
    1746         }
    1747 
    1748         return ret;
    1749 }

The problematic call tree is:

ath11k_bcn_tx_status_event() <- disables preempt
-> ath11k_mac_bcn_tx_event()
   -> ath11k_mac_setup_bcn_tmpl()
      -> ath11k_mac_setup_bcn_tmpl_ema()
      -> ath11k_mac_setup_bcn_tmpl_mbssid()
         -> ath11k_mac_set_vif_params()
            -> ath11k_mac_setup_bcn_p2p_ie()
               -> ath11k_wmi_p2p_go_bcn_ie()

The ath11k_bcn_tx_status_event() function takes rcu_read_lock() which
disables preemption.  I don't know the code well enough to say if this
is a real bug...  If it's a false positive, just ignore it.  These are
one time emails.

See my blog for more details.
https://staticthinking.wordpress.com/2024/05/24/sleeping-in-atomic-warnings/

regards,
dan carpenter

