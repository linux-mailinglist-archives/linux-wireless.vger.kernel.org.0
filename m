Return-Path: <linux-wireless+bounces-26861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA96B3B4B6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 09:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861893BE7AA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6510F2;
	Fri, 29 Aug 2025 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R25euKTd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20227B320
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453814; cv=none; b=XAusHiEyNqVCbu7fSxJJBzlftufF9ofNwl6PoWcOxhX24lmprbGAKTHOSQIXYtx2fSOdHioUK2G209lM53FDkVuDHEYqDgP+7+LlQjdMfQ+2sJzOvMSqU/PKLjQ/4pUlr1vu6zYAfEgfwC9cgzYjkH2Xczv/U0GPBzHu7UDjMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453814; c=relaxed/simple;
	bh=8Jse78G4QlB76c+tsQ7C20kf+WNqHWQYIM2dXN5cKYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rWlyTcWrrIqoeW6Lkj1R2AStbG/Qi7PU9ffl4PGBmMfZ1Ov9jAseWoEMLmmZcXExoBACUC0l2xppj1idkRzdGzYKqECJeDii8W+zMEEe4aBT4CaZiYQdzxMzYcYpGnoXoA/e1m1Zz76G1DbZkzQVcMspLx8m+BtH3K9S93/vVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R25euKTd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3d0dd9c9229so147808f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756453811; x=1757058611; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuDTKFoh9VZ8g3uZ9w4wJbd9vZYzL7SUTgf0hSz+48w=;
        b=R25euKTdsfHXFKKznTvT4XowTK5biIPeHC/1qcN9BErjcT1Ubo8CiMWIY9tPdYNgEW
         9n1QnNr5GGQ33vIx/IR1OTaIUoTY0Q37axAjocofsZFOZB0pp/yHSgk/CJqZLGdBb1q8
         RBuNVU/HWtfxP2YFZ2k8yeqykmhxqkAtc/pnIp4anegUKzlHqVi2RZxY7K2VQABqv5jy
         ifH7ffYUgWgsEP/c9vvG7RqZUKHslPROK9RERb4PSyJ7UnrsHP/woh/pN8ETJVpgROdK
         40dPSGNF4IxVFpMm6WwA88c/9MTg/FIKVi1j/uSlCAKDwpJd0X/nBPgAjX18A7+G8SSt
         yY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756453811; x=1757058611;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuDTKFoh9VZ8g3uZ9w4wJbd9vZYzL7SUTgf0hSz+48w=;
        b=XTfeDRHhqJkh3qDE+gl+zgt2TJ/VXDfo6XqvHJMGz6mPWRXm92/3/7z5R68llxWG3V
         7ZHNFWCAG9y5VeTTOPgKMAXIFytUTpJgB/IPT12LrFWaL06hrrAKc6LVcO19Nph+YOWE
         NvAlq1b4oqDR0xyK3vdPiWuyZdAAWWl7LusxAgfFYVXIl7nfUmfAUehnCQ23hwwwVdVI
         zo29+4yvPRbuuLy7QMm8OEPFjzUmrfkwed4rciok8H4QBr2je6oNPZTB/2Be7xqSs0fJ
         bIefq/jROJMXFdaNzbPJUfpNbL/qPqW0dF5Ixr3yRs/DjFroCktoq3A7OTNYc0EAGVwR
         Fmlw==
X-Gm-Message-State: AOJu0Yy9oJxb+Us7EEfeBRmOzhQsynOQVupzTbA6gdQDlOdq73Sgpg12
	dhby3gJo2hpZmgjkQa76bASLLS69OKfczgssUC76kKIfr5aeRCL4MzNRZkSWVu8jXGlCPGAM9nN
	TV0uc
X-Gm-Gg: ASbGncvWV/32Cuq+sdbslQnBJyzVmRBjQ8XtV3KmFG+xoQYxVIaSzzvkvj4E7n6c0L7
	zH4QNpJkcVkiZH9cPFGTzsHHlgL2cayOLS1kuoNjvrQ5i6Qe9G5Jre1fWBkac6K3gvDDCNK8XNJ
	8ZxlbREIrgHo2uvpt9YXDzB511hqkN4ATtNT/hJSYvxDekFZsLr8O+4h86SiVAbNG1sx/cbgymi
	0VFDtiPp7f/fWkreokwpU+V3BXHPp+Yl56UvfzT4p2CNM6njYTTjk5xFT7R76bqnnRVyqPKzazH
	Nxg0wXCD4wxuULbbAorKZkRsG5G7MWzA+07ID5dS8fsH4uDMia5IC8jGSO8TpLm5gqE2byvPzlJ
	An3YfLUHr3EtUvm8N9bOWp5mvebx1OQ/3LpCZJw==
X-Google-Smtp-Source: AGHT+IFizEK45QtkPKSmoHcSSsmcxldaOAW57n7KWRw3stL9V0mIQzUSCt6yGsgF6A8dXTyoAlpNoQ==
X-Received: by 2002:a05:6000:42c2:b0:3cb:285f:8da9 with SMTP id ffacd0b85a97d-3cb285f954emr6749816f8f.51.1756453810918;
        Fri, 29 Aug 2025 00:50:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf34493937sm2250829f8f.58.2025.08.29.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:50:10 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:50:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ajay Singh <ajay.kathat@microchip.com>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wilc1000: move wilc driver out of staging
Message-ID: <aLFbr9Yu9j_TQTey@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ajay Singh,

[ Obviously this bug was in staging as well...  ]

Commit 5625f965d764 ("wilc1000: move wilc driver out of staging")
from Jun 25, 2020 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/wireless/microchip/wilc1000/wlan_cfg.c:184 wilc_wlan_parse_response_frame()
	error: '__memcpy()' 'cfg->s[i]->str' copy overflow (512 vs 65537)

drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
    138 static void wilc_wlan_parse_response_frame(struct wilc *wl, u8 *info, int size)
    139 {
    140         u16 wid;
    141         u32 len = 0, i = 0;
    142         struct wilc_cfg *cfg = &wl->cfg;
    143 
    144         while (size > 0) {
    145                 i = 0;
    146                 wid = get_unaligned_le16(info);
    147 
    148                 switch (FIELD_GET(WILC_WID_TYPE, wid)) {
    149                 case WID_CHAR:
    150                         while (cfg->b[i].id != WID_NIL && cfg->b[i].id != wid)
    151                                 i++;
    152 

This is the rx path and info comes from skb->data so it feels like we
need more bounds  checking.

	if (info < 5)
		return;

    153                         if (cfg->b[i].id == wid)
    154                                 cfg->b[i].val = info[4];
    155 
    156                         len = 3;
    157                         break;
    158 
    159                 case WID_SHORT:

	if (info < 6)
		return;

    160                         while (cfg->hw[i].id != WID_NIL && cfg->hw[i].id != wid)
    161                                 i++;
    162 
    163                         if (cfg->hw[i].id == wid)
    164                                 cfg->hw[i].val = get_unaligned_le16(&info[4]);
    165 
    166                         len = 4;
    167                         break;
    168 
    169                 case WID_INT:

	if (info < 8)
		return;

    170                         while (cfg->w[i].id != WID_NIL && cfg->w[i].id != wid)
    171                                 i++;
    172 
    173                         if (cfg->w[i].id == wid)
    174                                 cfg->w[i].val = get_unaligned_le32(&info[4]);
    175 
    176                         len = 6;
    177                         break;
    178 
    179                 case WID_STR:

How many bytes are there in cfg->s[i].str?  Smatch thinks 512, but I
don't know where Smatch is getting that...

	len = 2 + get_unaligned_le16(&info[2]);
	if (len + 2 > SOME_LIMIT)
		return;

    180                         while (cfg->s[i].id != WID_NIL && cfg->s[i].id != wid)
    181                                 i++;
    182 
    183                         if (cfg->s[i].id == wid)
--> 184                                 memcpy(cfg->s[i].str, &info[2],
    185                                        get_unaligned_le16(&info[2]) + 2);
    186 
    187                         len = 2 + get_unaligned_le16(&info[2]);
    188                         break;
    189 
    190                 default:
    191                         break;
    192                 }
    193                 size -= (2 + len);
    194                 info += (2 + len);
    195         }
    196 }

regards,
dan carpenter

