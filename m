Return-Path: <linux-wireless+bounces-34575-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAyEOIrN2GngiQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34575-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:14:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A473D5821
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCCF13029A76
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB5382383;
	Fri, 10 Apr 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1GzZZLD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550D332608
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816030; cv=none; b=fWXhAy/h5dlRj8dJpSd8TFRLVYFLUl/U6NstiQ8qhLE/BlH51B0g/FedfDwg8QCDRUq8l4ddqGbkg/z068NrZ1p4eP2JA0TfEyvBksxAmJD7ZLVBpRD9MdcKtbIMpe2GIzuiVHMU22KXYaJjBF8s6rCdBr4dTRL8zWvplnh2uSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816030; c=relaxed/simple;
	bh=FBK6m/b6zKWgu9TIGFz8Qh/zdZIfL0933jGF1+DS3NY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AXHAV2IEkwxvYei1ucHINxyivPMJLH7jHz745sT2Oezcu5FadMPyOUkb7KOz7lDXQ7r3KBHzVE0P95yztKVZHLXurFJqfXOwpp/jJ+uKgO+lCLIxjOP60ktlwBQcGWCaEjJexUCgoWPNk6LNAyp+D4/sd92Pm/Ua3E9jyemXeIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1GzZZLD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so12374385e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816027; x=1776420827; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wet2DYKEwk3JQ9CbL3lHmxBHJf7aDapnyclx38VwBQc=;
        b=s1GzZZLDpvQ0+QHDz9eiZlT1E+w64VDMoNNIUiJ1AjXovVhAwXKsScVCkMjwK7lVZR
         NHF3Y2AARopB1Qmg0b3/hlUdkrnF+/KDZ0L82YermJqt2O+ROyy634QmXcWO7rclVBMy
         m7iE871p0wzdnpI3wCrZjqin0X69msVxQf3JBh1cRZNy+j7aM4G/w1v0eRDNB8H7cZA0
         QhVqDChS+4k8cWRcIfphDQVrWCHFuiO/7gYOoxyxP9AjudiQvlzmfNamN3eFGPBfjKgZ
         iPekzoTO5mfgnHsOaeqyvn1fKQQQcAFSjjbYdYGyahpSuqpTyC+fsMQkTL+5ObJBQWMz
         kzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816027; x=1776420827;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wet2DYKEwk3JQ9CbL3lHmxBHJf7aDapnyclx38VwBQc=;
        b=e9+wHEowWZQ6CrwXIgtflx2klYmV/OKs9oEAh74HJ1VMLRhOxPhjw/MnKMCaF4G7NR
         9EPBlpmH9cqWRJPdX+eWn/NRtJ945WTqGA+rtJpsEU8tZOXe56e1CnnNyev6zrmOhQxx
         HYmwUuTWWTBrs1bHX6iyei+b7FpInDopEhWdeNKDqfTV1Vh8Zab1SYNVdDGhf2+WwJO2
         gsZX6zYmUJucvv9JtKV9HElhPfnKbClJfVGFGba8Wxcikt2fxIiO1RI4kaIx5mJgMEea
         t3Q7aDm7GVlj3NGAU79EO1s0vZwEkSpVkLNiwC6PT7nJ9R6sOMG2z5kaeSw5gKP4QxyY
         Fy4g==
X-Gm-Message-State: AOJu0YxrIurPWZsHVCvyfwXhVhMcw7ZY0EQJ8oWwcVY4JqA6eCQsPLWw
	2GAuAIJ8qDTkOqupkPe+5XUid+tPK06IPu+3cZ2dHsNzvL8VSW5dBJse
X-Gm-Gg: AeBDietFu6ZCbdnK1L8Rtt3cSB0KM+oPK/OEH9mJmcS7nfLBTLdk+HmB3Rwu2rKsDAn
	cadeMNgk/r2oNqygY73JuTuTmE57Me0nPgkCTHU5kmtE3IBr941KYQRBOeVaZVj/6Q/T4sgPvrx
	R0es4ICuJTmFu2FPTqlbTo6cxXGO60wucnpEaFuy1mNWUjOwBC26ax19lIYU2IyYclygODnhLjJ
	UOUpfnJJ+QxU2SeOhnt/UnGEm+9CUiDtnKlDdWPq0SXuN2V3fSYl4uoaOw/mEP+L9gqthqdog8b
	x+w2oWO+pyLe+X4mo3DM6Q5Fa7Wg2UVcAxMWgcNxHuuBtVXPzKVOimhEjMEYU0iutXTEv7pImpe
	MGVhbS5ww1fjhJj4EmbdcgfDGiydcmk0CFjgLvByI3hI+/oXYj+2BdUaZsWXSGKKVL6HV4IKYuF
	Y1F9E24ui4+vTFF0aJMlyhx4R/pBvFyw==
X-Received: by 2002:a05:600c:c117:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-488d68af0e7mr21886205e9.19.1775816026971;
        Fri, 10 Apr 2026 03:13:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm36755705e9.5.2026.04.10.03.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:13:46 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:13:43 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: mt7996: Integrate MT7990 dma configuration
 for NPU
Message-ID: <adjNVyjGFNxvJIW8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34575-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: 69A473D5821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Lorenzo Bianconi,

Commit cd7951f242a7 ("wifi: mt76: mt7996: Integrate MT7990 dma
configuration for NPU") from Jan 22, 2026 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7996/dma.c:683 mt7996_dma_init()
	error: NULL dereference inside function mt7996_init_tx_queues()

drivers/net/wireless/mediatek/mt76/mt7996/dma.c
    664 int mt7996_dma_init(struct mt7996_dev *dev)
    665 {
    666         struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
    667         struct mtk_wed_device *wed_hif2 = &dev->mt76.mmio.wed_hif2;
    668         u32 rx_base;
    669         u32 hif1_ofs = 0;
    670         int ret;
    671 
    672         mt7996_dma_config(dev);
    673 
    674         mt76_dma_attach(&dev->mt76);
    675 
    676         if (dev->hif2)
    677                 hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
    678 
    679         mt7996_dma_disable(dev, true);
    680 
    681         /* init tx queue */
    682         if (is_mt7996(&dev->mt76) && mt76_npu_device_active(&dev->mt76))
--> 683                 ret = mt7996_init_tx_queues(&dev->phy, MT_TXQ_ID(0),
    684                                             MT7996_NPU_TX_RING_SIZE,
    685                                             MT_TXQ_RING_BASE(0) + hif1_ofs,
    686                                             NULL);
                                                    ^^^^
Can't pass NULL here.  It leads to a crash.  Use wed?

    687         else
    688                 ret = mt7996_init_tx_queues(&dev->phy,
    689                                             MT_TXQ_ID(dev->mphy.band_idx),
    690                                             MT7996_TX_RING_SIZE,
    691                                             MT_TXQ_RING_BASE(0), wed);
    692         if (ret)
    693                 return ret;
    694 

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

