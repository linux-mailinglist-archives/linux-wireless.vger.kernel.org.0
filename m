Return-Path: <linux-wireless+bounces-582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C990880A8DA
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 17:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FD2B20B2A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5145374EC;
	Fri,  8 Dec 2023 16:27:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744A19A2;
	Fri,  8 Dec 2023 08:27:31 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d9f514f796so256476a34.3;
        Fri, 08 Dec 2023 08:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052850; x=1702657650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9ER5qIprpwLYgCbIQAvqPacoHFK4xi4mCA2pH+f0WM=;
        b=YiAYbI9hGXLuDpo/mBPT432mwQk6/f35zQvDWfP2+WCI6dSV9KQXIrkvjFwrtsFjxn
         qExgaTU409RicCepC5szRM+PXdq53Ef1ICHtwciTVZjHJANFlLQWNaurqwMB5qBnIqrt
         eK6tFcPuYbGxOh6HizRQgXjsJdf5Vh7ELv6VXumVR3mUyEBaHnPhfu8cAlSdE3OFeXl2
         dcYf4u9dfQ3Mc2efiii/+3tmwEZ5Rz8UCmB4c/srKCxigh/mWKrjKARi5HR2++udB56J
         L1PbTY+Ndd+njcjGl3FujNpG76jXaB/gBaYJ9WfBTAcNRe7iStSB16YxRw+WGAPoK4Yf
         ac3A==
X-Gm-Message-State: AOJu0YxRbAnFfpzOZiAyvtstH+U5Fd5CRxqGAJISrm8pd8NiV6pgTabG
	0zzczR0B3rJehnHc9ExLNrLtz/0GMA==
X-Google-Smtp-Source: AGHT+IGoCBIdUoYHkFT9QQgUxa2omYYXOQwXX4AzFygvyqUJIp41c4SIZsAORINlyDflchYMlvWtxg==
X-Received: by 2002:a9d:7758:0:b0:6d9:dd14:3a75 with SMTP id t24-20020a9d7758000000b006d9dd143a75mr304450otl.70.1702052850656;
        Fri, 08 Dec 2023 08:27:30 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e7-20020a0568301e4700b006d87df1c53dsm339278otj.65.2023.12.08.08.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:27:30 -0800 (PST)
Received: (nullmailer pid 1634379 invoked by uid 1000);
	Fri, 08 Dec 2023 16:27:29 -0000
Date: Fri, 8 Dec 2023 10:27:29 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Ryder Lee <ryder.Lee@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sam Shih <sam.shih@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: net: wireless: mt76: add interrupts
 description for MT7986
Message-ID: <20231208162729.GA1575094-robh@kernel.org>
References: <20231204091156.6535-1-chui-hao.chiu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204091156.6535-1-chui-hao.chiu@mediatek.com>

On Mon, Dec 04, 2023 at 05:11:56PM +0800, Peter Chiu wrote:
> The mt7986 can support four interrupts to distribute the interrupts
> to different CPUs.
> 
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
> v2: Change to use description instead of using items.

Not what I said to do...

Let me spell it out:

  interrupts:
    minItems: 1
      items:
        - description: major interrupt for rings
        - description: addditional interrupt for ring 19
        - description: addditional interrupt for ring 4
        - description: addditional interrupt for ring 5

if:
  properties:
    compatible:
      contains:
        enum:
          - mediatek,mt7986-wmac
then:
  properties:
    interrupts:
      minItems: 4
else:
  properties:
    interrupts:
      maxItems: 1


If there are 4 interrupts then you should always have all 4. It's not 
some OS config. However, as an ABI, you might want to allow 1. If so, 
then the if/then should just have the 'maxItems: 1' restriction for the 
compatibles which only have 1 interrupt in the h/w.

Rob

