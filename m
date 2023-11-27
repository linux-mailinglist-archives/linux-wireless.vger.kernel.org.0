Return-Path: <linux-wireless+bounces-128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FD7FAB68
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F912281BDF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F015046449;
	Mon, 27 Nov 2023 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="CITmsuf4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2987E19A6;
	Mon, 27 Nov 2023 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
	t=1701116852; bh=wjGIuleQ8kD0z2aVCMJjHMNPVmJYR139BLY4d6XpI1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CITmsuf4OwScTPbofNMOSgAtZ0drI/A4I02RxAI8Q9XCGQdfw8Gjn+WBillie3caD
	 E5iR5ev6U/j/hvZOmRcTns+y0IavwYPaRysGzBKB6OUZwCyRkp36FWeFNF1qhkWbRg
	 GE9GZ06SNeLT41ez/Go5UlAPQVoL/XsYOlZYg24s=
From: Luca Weiss <luca@z3ntu.xyz>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Loic Poulain <loic.poulain@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject:
 Re: [PATCH 1/4] dt-bindings: remoteproc: qcom: wcnss: Add WCN3680B compatible
Date: Mon, 27 Nov 2023 21:27:30 +0100
Message-ID: <5919350.DvuYhMxLoT@z3ntu.xyz>
In-Reply-To: <ZWT3APJlNQaKVyJU@gerhold.net>
References:
 <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
 <1868698.tdWV9SEqCh@z3ntu.xyz> <ZWT3APJlNQaKVyJU@gerhold.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 27. November 2023 21:07:28 CET Stephan Gerhold wrote:
> On Sat, Nov 25, 2023 at 01:25:22PM +0100, Luca Weiss wrote:
> > On Montag, 16. Oktober 2023 16:44:28 CET Stephan Gerhold wrote:
> > > On Mon, Oct 16, 2023 at 03:16:14PM +0200, Loic Poulain wrote:
> > > > On Mon, 16 Oct 2023 at 07:35, Krzysztof Kozlowski
> > > > 
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > > On 15/10/2023 22:03, Luca Weiss wrote:
> > > > > > Add a compatible for the iris subnode in the WCNSS PIL.
> > > > > > 
> > > > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > > > ---
> > > > > > 
> > > > > >  Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > >  | 1
> > > > > >  +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > > b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > > > > > index 45eb42bd3c2c..0e5e0b7a0610 100644
> > > > > > ---
> > > > > > a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yam
> > > > > > l
> > > > > > +++
> > > > > > b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yam
> > > > > > l
> > > > > > 
> > > > > > @@ -111,6 +111,7 @@ properties:
> > > > > >            - qcom,wcn3660
> > > > > >            - qcom,wcn3660b
> > > > > >            - qcom,wcn3680
> > > > > > 
> > > > > > +          - qcom,wcn3680b
> > > > > 
> > > > > Looks like this should be made as compatible with qcom,wcn3680 (so
> > > > > with
> > > > > fallback).
> > > > 
> > > > Yes, agree, let's do a regular fallback as there is nothing 'b'
> > > > specific in the driver:
> > > > `compatible = "qcom,wcn3680b", "qcom,wcn3680";`
> > > > 
> > > > And yes, we should also have done that for qcom,wcn3660b...
> > > 
> > > I don't think this would have worked properly for qcom,wcn3660b:
> > >  - It's not compatible with "qcom,wcn3660", because they have different
> > >  
> > >    regulator voltage requirements. wcn3660(a?) needs vddpa with
> > >    2.9-3.0V, but wcn3660b needs 3.3V. That's why wcn3660b uses the
> > >    wcn3680_data in qcom_wcnss.iris.c. Otherwise if you would run an
> > >    older kernel that knows "qcom,wcn3660" but not "qcom,wcn3660b" it
> > >    would apply the wrong voltage.
> > >  
> > >  - It's not compatible with "qcom,wcn3680" either because that is used
> > >  
> > >    as indication if 802.11ac is supported (wcn3660b doesn't).
> > > 
> > > The main question here is: What does the current "qcom,wcn3680"
> > > compatible actually represent? It's defined with vddpa = 3.3V in the
> > > 
> > > driver, which would suggest that:
> > >  1. It's actually meant to represent WCN3680B, which needs 3.3V vddpa
> > >  
> > >     like WCN3660B, or
> > >  
> > >  2. WCN3680(A?) has different requirements than WCN3660(A?) and also
> > >  
> > >     needs 3.3V vddpa. But then what is the difference between
> > >     WCN3680(A?) and WCN3680B? Is there even a variant without ...B?
> > > 
> > > There is public documentation for WCN3660B and WCN3680B but the non-B
> > > variants are shrouded in mystery.
> > 
> > Hi Stephan (and everyone),
> > 
> > Do you have a suggestion how to move this patchset forward? Is the
> > fallback
> > compatible that was suggested okay for the wcn3680b situation?
> > 
> >   compatible = "qcom,wcn3680b", "qcom,wcn3680";
> > 
> > If so, I'll make v2 with that implemented.
> 
> Personally, I would just go with what exists already and use the
> existing "qcom,wcn3680" compatible as-is. No one has provided evidence
> that there is actually something like a WCN3680(A), without a 'B' at the
> end. Also, all existing users of the "qcom,wcn3680" compatible upstream
> actually seem to refer to WCN3680B (I'm quite sure apq8039-t2 has
> WCN3680B, MSM8974 isn't entirely clear but iirc you mentioned there was
> some schematic of a MSM8974 device which says WCN3680B as well).
> 
> It would be nice to have the compatible perfectly correct and complete,
> but I see no point to extend it with additional information that we
> can't properly verify.
> 
> Or do you actually need a different compatible to customize something in
> the driver?

No it should be fine with qcom,wcn3680.

I'll send v2 in the coming days then, thanks for your input!

Regards
Luca

> 
> Thanks,
> Stephan





