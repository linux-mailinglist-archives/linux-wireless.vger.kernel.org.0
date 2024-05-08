Return-Path: <linux-wireless+bounces-7341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D68BFD1C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 14:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610C01F22DBE
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816B682C6B;
	Wed,  8 May 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOqtsVlh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC7282862
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171372; cv=none; b=ICKwNHk9EPm34dke+NnTQWOI9VfjWI4uti3nPKkFHty3A0/GzWYMquQB1yJPcrUrccUQduErTTAudSGcLRdqttvTpjo0NHcB2rVx5i3EoIeFthLvjV+PehZeJV7lXq+S2VIzfhx+GvDcAtFCoyWtZiNlK1ygoy3ulGbC5OIXnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171372; c=relaxed/simple;
	bh=9hTIlto+nNi6gS2Krq6P1Tak3q0UqFBDx1cg6iezur4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OSpWiZgyv7xOU6OGvSrfsLY1EDSC69NSHmWAiytt0V1v34drO3mVIz5opefTtFMhbERMy9nlIp9UCaZdNyUGR5IodBGh5mA9Qb3zXr9BEJmuJKspISXnaPEKeM7XIn29F9CW/EnL614QWN4TaASaosdQRK6xXI+6h7VXBvVAN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOqtsVlh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cf8140d0so844709366b.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715171369; x=1715776169; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrrGPAq63QCB3MtkFDf/C+/vtNGFMQ8dGk2GFJgvSrU=;
        b=kOqtsVlh2dP5FmUXbzR6/BgWki/+6cdV1v2zkIXOiVnhA2eNwNUhv5CIlAMPMdhQUl
         ABvlvTV6njxvNwHN2iYaGifFpTn+KMYh5wB7BFZUTkn4gdahRq8jNs8pCOjawnuSLzO8
         jPkpe0DR11Y15MZyqGeeO4VGFpWvu0nEw/LJ79z3BwNzNGTZZna/b7hVlu3BvNunT9Mg
         wIwv2eu37F7vbGqwVbUf8sLRCoSQjKtQMLoG7QCarh2+4yXk+vOEOs/JzMrqYInsE0Ai
         NheyXcmicQGFLLRvaA3fFkN9H6sa/BQGasq+l88E4y7plKW3k0zQ+cfafNIV4QO8mJ/G
         7gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715171369; x=1715776169;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrrGPAq63QCB3MtkFDf/C+/vtNGFMQ8dGk2GFJgvSrU=;
        b=RsRM+I20nnFLxL7Xxz1SLIlsUh/LNSWIHHPIJPtXLtNSOTJW03gqfV/fDJHUDAjZ4j
         whzmxGgPDVEYd/WEMH7gSd88m/42rm0P3RRnmsWoUGpW+/cVued8QDgmS/UMckLueDm9
         VIacVVpOBmYgsPWtRSfDLkFJx66K8GaQF+mjD2ROKNExe8aBdPILjDkXQfwprTUTeNvE
         nRw376TNORJy9SksBK9K+mACgUihWN1kXI59rycRVkgF+/7JT/elmnv/KLW6J+xJ1rpt
         k6W74CG2RjzcUVqt5DO7gZ1ygD8WYzPwulQcvLG+aOclBLPRiODR/cXl6gBzSmjAvTUZ
         B6Ng==
X-Gm-Message-State: AOJu0YwAIzmUBP72NGymhBhKHDUFH/cX7cT4RvJGfUCV03ixAKnKKuzp
	cmKg+A4WnPbmUoiafVnS3F8LjOgXDci5bp4CgOV9XcH9eTZ1b5PxCEWxSqjBaqtZXMBkrhmwHUW
	t
X-Google-Smtp-Source: AGHT+IEXHT82LKEfyEmTpLYruC5p8iUP+itIIbvEMOW/7yXOm0eX3R221ONDVAoP2sIsVt2ksDJSQQ==
X-Received: by 2002:a17:906:6d04:b0:a59:d3ec:4f33 with SMTP id a640c23a62f3a-a59fb952bd1mr156424466b.39.1715171368851;
        Wed, 08 May 2024 05:29:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170906adce00b00a59bc8c01b1sm4562644ejb.82.2024.05.08.05.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 05:29:28 -0700 (PDT)
Date: Wed, 8 May 2024 15:29:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: quic_bqiang@quicinc.com
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Subject: [bug report] wifi: ath12k: flush all packets before suspend
Message-ID: <7a96ca11-80b5-4751-8cfc-fa637f3aa63a@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Baochen Qiang,

Commit 692921ead832 ("wifi: ath12k: flush all packets before
suspend") from Apr 22, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/net/wireless/ath/ath12k/core.c:58 ath12k_core_suspend()
	warn: sleeping in atomic context

drivers/net/wireless/ath/ath12k/core.c
    48         int ret, i;
    49 
    50         if (!ab->hw_params->supports_suspend)
    51                 return -EOPNOTSUPP;
    52 
    53         rcu_read_lock();
               ^^^^^^^^^^^^^^^
Disables preemption.

    54         for (i = 0; i < ab->num_radios; i++) {
    55                 ar = ath12k_mac_get_ar_by_pdev_id(ab, i);
    56                 if (!ar)
    57                         continue;
--> 58                 ret = ath12k_mac_wait_tx_complete(ar);
                                        ^^^^^^^
Sleeping in atomic context.

    59                 if (ret) {
    60                         ath12k_warn(ab, "failed to wait tx complete: %d\n", ret);
    61                         rcu_read_unlock();
    62                         return ret;
    63                 }
    64         }
    65         rcu_read_unlock();

regards,
dan carpenter

